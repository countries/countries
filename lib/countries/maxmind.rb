module Maxmind; end

class Maxmind::City
  
  def initialize(data)
    @data = data
  end

  def name
    @data["accentcity"]
  end

  def latitude
    return nil if @data["latitude"].nil?
    @data["latitude"].to_f
  end

  def longitude
    return nil if @data["longitude"].nil?
    @data["longitude"].to_f
  end

  def latlong?
    latitude && longitude
  end

  def latlong
    latlong? ? [latitude, longitude] : nil
  end

  def population
    return nil if @data["population"].nil?
    @data["population"].to_i
  end

  def region
    @data["region"]
  end

  class << self

    def path_for_country(code)
      File.join(File.dirname(__FILE__), '..', 'data', 'cities', "#{code}.yaml")
    end

    def cities_in_country?(code)
      File.exist?(self.path_for_country(code))
    end
    
    def cities_in_country(code)
      if self.cities_in_country?(code)
        hash, cities = YAML.load_file(self.path_for_country(code)), {}
        hash.each{ |key, data| cities[key] = Maxmind::City.new(data) }
        cities
      else
        {}
      end
    end

  end

end
