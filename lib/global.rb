require 'countries/version'

require 'iso3166'

require 'countries/mongoid' if defined?(Mongoid)

class Country < ISO3166::Country
  def to_s
    warn "[DEPRECATION] `Country` is deprecated.  Please use `ISO3166::Country` instead."
    name
  end
end
