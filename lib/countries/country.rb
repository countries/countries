module ISO3166; end

class ISO3166::Country
  Data = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'data', 'countries.yaml')) || {}
  Names = Data.map {|k,v| [v['name'],k]}.sort
  NameIndex = Hash[*Names.flatten]

  AttrReaders = [
    :number,
    :alpha2,
    :alpha3,
    :name,
    :names,
    :latitude,
    :longitude,
    :region,
    :subregion,
    :country_code,
    :national_destination_code_lengths,
    :national_number_lengths,
    :international_prefix,
    :national_prefix,
    :address_format
  ]

  AttrReaders.each do |meth|
    define_method meth do
      @data[meth.to_s]
    end
  end

  attr_reader :data

  def initialize(country_code)
    @data = Data[country_code]
  end
  
  def valid?
    !!@data
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

  def cities
    Maxmind::City.cities_in_country(alpha2)
  end

  def cities?
    Maxmind::City.cities_in_country?(alpha2)
  end
  
  class << self
    def all
      Data.map { |country,data| [data['name'],country] }
    end
    
    alias :countries :all

    def search(query)
      country = self.new(query.to_s.upcase)
      country.valid? ? country : false
    end

    def [](query)
      self.search(query)
    end

    def find_by_name(name)
      name.downcase!
      Data.select do |k,v|
        v["name"].downcase == name || v["names"].map{ |n| n.downcase }.include?(name)
      end.first
    end

    def find_country_by_name(name)
      result = self.find_by_name(name)
      result ? self.new(result.first) : nil
    end
  end
end
