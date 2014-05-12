module ISO3166; end

class ISO3166::Country
  Data = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'data', 'countries.yaml')) || {}
  Names = Data.map {|k,v| [v['name'],k]}.sort_by { |d| d[0] }
  NameIndex = Hash[*Names.flatten]

  AttrReaders = [
    :number,
    :alpha2,
    :alpha3,
    :currency,
    :name,
    :names,
    :latitude,
    :longitude,
    :continent,
    :region,
    :subregion,
    :country_code,
    :national_destination_code_lengths,
    :national_number_lengths,
    :international_prefix,
    :national_prefix,
    :address_format,
    :ioc,
    :un_locode,
    :languages,
    :nationality
  ]

  AttrReaders.each do |meth|
    define_method meth do
      @data[meth.to_s]
    end
  end

  attr_reader :data

  def initialize(country_data)
    @data = country_data.is_a?(Hash) ? country_data : Data[country_data]
  end

  def valid?
    !!@data
  end

  def ==(other)
    self.data == other.data
  end

  def currency
    ISO4217::Currency.from_code(@data['currency'])
  end

  def subdivisions
    @subdivisions ||= subdivisions? ? YAML.load_file(File.join(File.dirname(__FILE__), '..', 'data', 'subdivisions', "#{alpha2}.yaml")) : {}
  end

  alias :states :subdivisions

  def subdivisions?
    File.exist?(File.join(File.dirname(__FILE__), '..', 'data', 'subdivisions', "#{alpha2}.yaml"))
  end

  class << self
    def all(&blk)
      (block_given?) ? Data.map( &blk ) : Names
    end

    alias :countries :all

    def search(query)
      country = self.new(query.to_s.upcase)
      country.valid? ? country : false
    end

    def [](query)
      self.search(query)
    end

    def method_missing(*m)
      if m.first.to_s.match /^find_(country_)?by_(.+)/
        country = self.find_all_by($~[2].downcase, m[1]).first
        $~[1].nil? ? country : self.new(country.last) if country
      elsif m.first.to_s.match /^find_all_(countries_)?by_(.+)/
        self.find_all_by($~[2].downcase, m[1]).inject([]) do |list, c|
          list << ($~[1].nil? ? c : self.new(c.last)) if c
          list
        end
      else
        super
      end
    end

    def find_all_by(attribute, val)
      raise "Invalid attribute name '#{attribute}'" unless AttrReaders.include?(attribute.to_sym)
      attribute = attribute.to_s
      if val.is_a?(Regexp)
        val = Regexp.new(val.source, 'i')
      else
        val = val.to_s.downcase
      end
      attribute = ['name', 'names'] if attribute == 'name'
      Data.select do |k,v|
        Array(attribute).map do |attr|
          if v[attr].kind_of?(Enumerable)
            v[attr].any?{ |n| val === n.downcase }
          else
            v[attr] && val === v[attr].downcase
          end
        end.uniq.include?(true)
      end
    end

  end
end
