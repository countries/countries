class Country
  attr_reader :data
   
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
  
  Data = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'data', 'countries.yaml')) || {}
  Names = Data.map {|k,v| [v['name'],k]}.sort
  NameIndex = Hash[*Names.flatten]
    
  def initialize(country_code)
    @data = Data[country_code]
  end
  
  def currency
    Currency.from_code(@data['currency'])
  end
  
  def self.search(query)
    Country.new(query)
  end
  
  def self.[](query)
    self.search(query)
  end
  
  def subdivisions
    @subdivisions ||= subdivisions? ? YAML.load_file(File.join(File.dirname(__FILE__), '..', 'data', 'subdivisions', "#{alpha2}.yaml")) : {}
  end
  
  def subdivisions?
    File.exist?(File.join(File.dirname(__FILE__), '..', 'data', 'subdivisions', "#{alpha2}.yaml"))
  end
end