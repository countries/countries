$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

require 'iso3166'

class Country < ISO3166::Country; end
