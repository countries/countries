class Country
  Data = File.open( 'lib/data/countries.yaml' ) { |yaml| YAML::load( yaml ) }
  
  attr_reader :number, :alpha2, :alpha3, :name, :names, :latitude, :longitude, :region, :subregion, :country_code, :national_destination_code_lengths, :national_number_lengths, :international_prefix, :national_prefix

    
  def initialize(data)
    @number = data['number']
    @alpha2 = data['alpha2']
    @alpha3 = data['alpha3']
    @name = data['name']
    @names = data['names']
    @latitude = data['latitude']
    @longitude = data['longitude']
    @region = data['region']
    @subregion = data['subregion']
    
    @country_code = data['e164_country_code']
    @national_destination_code_lengths = data['e164_national_destination_code_lengths']
    @national_number_lengths = data['e164_national_number_lengths']
    @international_prefix = data['e164_international_prefix']
    @national_prefix = data['e164_national_prefix']
  end
  
  def self.[](search)
    Country.new(Data[search])
  end
end

class State
end