require "countries/version"

require 'iso3166'
require 'countries/mongoid' if defined?(Mongoid)

class Country < ISO3166::Country
  def to_s
    self.name
  end
end
