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
    :translations,
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
    :nationality,
    :eu_member
  ]

  AttrReaders.each do |meth|
    define_method meth do
      @data[meth.to_s]
    end
  end

  attr_reader :data

  def initialize(country_data)
    @data = country_data.is_a?(Hash) ? country_data : Data[country_data.to_s.upcase]
  end

  def valid?
    not (@data.nil? or @data.empty?)
  end

  def ==(other)
    self.data == other.data
  end

  def currency
    ISO4217::Currency.from_code(@data['currency'])
  end

  def currency_code
    @data['currency']
  end

  def subdivisions
    @subdivisions ||= subdivisions? ? YAML.load_file(File.join(File.dirname(__FILE__), '..', 'data', 'subdivisions', "#{alpha2}.yaml")) : {}
  end

  alias :states :subdivisions

  def subdivisions?
    File.exist?(File.join(File.dirname(__FILE__), '..', 'data', 'subdivisions', "#{alpha2}.yaml"))
  end

  def in_eu?
    @data['eu_member'].nil? ? false : @data['eu_member']
  end

  def to_s
    @data['name']
  end

  class << self
    def new(country_data)
      if country_data.is_a?(Hash) || Data.keys.include?(country_data.to_s.upcase)
        super
      end
    end

    def all(&blk)
      blk ||= Proc.new { |country ,data| [data['name'], country] }
      Data.map &blk
    end

    alias :countries :all

    def search(query)
      country = self.new(query.to_s.upcase)
      (country && country.valid?) ? country : nil
    end

    def [](query)
      self.search(query)
    end

    def method_missing(*m)
      regex = m.first.to_s.match(/^find_(all_)?(country_|countries_)?by_(.+)/)
      super unless regex

      countries = self.find_by($3, m[1], $2)
      $1 ? countries : countries.last
    end

    def find_all_by(attribute, val)
      attributes, value = parse_attributes(attribute, val)

      Data.select do |_, v|
        attributes.map do |attr|
          Array(v[attr]).any?{ |n| value === n.to_s.downcase }
        end.include?(true)
      end
    end

    protected
    def parse_attributes(attribute, val)
      raise "Invalid attribute name '#{attribute}'" unless AttrReaders.include?(attribute.to_sym)

      attributes = Array(attribute.to_s)
      attributes << 'names' if attributes == ['name']

      val = (val.is_a?(Regexp) ? Regexp.new(val.source, 'i') : val.to_s.downcase)

      [attributes, val]
    end

    def find_by(attribute, value, obj = nil)
      self.find_all_by(attribute.downcase, value).map do |country|
        obj.nil? ? country : self.new(country.last)
      end
    end
  end
end
