require 'countries/version'

require 'iso3166'
require 'countries/mongoid' if defined?(Mongoid)

unless defined? Country
  class Country < ISO3166::Country
    def to_s
      name
    end
  end
end
