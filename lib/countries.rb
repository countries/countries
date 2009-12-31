class Country
  #Data = File.open( 'lib/data/countries.yaml' ) {|yaml| YAML::load( yaml )}
  Data = YAML.load_file(File.join(File.dirname(__FILE__), 'data', 'countries.yaml')) || {}
  Names = Data.map {|code,data| data[:name]}
  
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
  
  def self.search(query)
    Country.new(Data[query])
  end
  
  def self.[](query)
    self.search(query)
  end
  
  def subdivisions
    @subdivisions ||= subdivisions? ? YAML.load_file(File.join(File.dirname(__FILE__), 'data', 'subdivisions', "#{alpha2}.yaml")) : {}
  end
  
  def subdivisions?
    File.exist?(File.join(File.dirname(__FILE__), 'data', 'subdivisions', "#{alpha2}.yaml"))
  end
end

# CountrySelect - stolen from http://github.com/rails/iso-3166-country-select
module ActionView
  module Helpers
    module FormOptionsHelper

      def country_select(object, method, priority_countries = nil, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_country_select_tag(priority_countries, options, html_options)
      end

      def country_options_for_select(selected = nil, priority_countries = nil)
        country_options = ""

        if priority_countries
          country_options += options_for_select(priority_countries, selected)
          country_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n"
        end

        return country_options + options_for_select(Country::Names, selected)
      end
    end
    
    class InstanceTag
      def to_country_select_tag(priority_countries, options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select",
          add_options(
            country_options_for_select(value, priority_countries),
            options, value
          ), html_options
        )
      end
    end
    
    class FormBuilder
      def country_select(method, priority_countries = nil, options = {}, html_options = {})
        @template.country_select(@object_name, method, priority_countries, options.merge(:object => @object), html_options)
      end
    end
  end
end