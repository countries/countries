require "countries/version"

require 'iso3166'
require 'countries/mongoid' if defined?(Mongoid)

if defined?(ActiveRecord)
  require 'countries/active-record'
  require 'countries/railtie'
else

  class Country < ISO3166::Country
    def to_s
      self.name
    end
  end

end
