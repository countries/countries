require 'geocoder'
require 'retryable'

Geocoder.configure(
  timeout: 10
)

# raise on geocoding errors such as query limit exceeded
Geocoder.configure(always_raise: :all)
# Try to geocode a given query, on exceptions it retries up to 3 times then gives up.
# @param [String] query string to geocode
# @return [Hash] first valid result or nil
def geocode(query)
  Retryable.retryable(tries: 3, sleep: ->(n) { 2**n }) do
    Geocoder.search(query).first
  end
rescue => e
  warn "Attempts exceeded for query #{query}, last error was #{e.message}"
  nil
end

def load_country_yaml(alpha2)
  YAML.load_file(File.join(ISO3166_ROOT_PATH, 'lib', 'countries', 'data', 'countries', "#{alpha2}.yaml"))
end

def save_country_yaml(alpha2, data)
  File.open(File.join(ISO3166_ROOT_PATH, 'lib', 'countries', 'data', 'countries', "#{alpha2}.yaml"), 'w+') { |f| f.write data.to_yaml }
end

def country_codes
  @country_codes ||= Dir['lib/countries/data/countries/*.yaml'].map { |x| File.basename(x, File.extname(x)) }.uniq
end

namespace :geocode do
  desc 'Retrieve and store subdivisions coordinates'
  task :fetch_countries do
    require 'countries'
    # Iterate over countries
    ISO3166::Country.all.each do |country|
      code = country.alpha2
      # Load unmutated yaml file.
      data = load_country_yaml(country.alpha2)

      lookup = "#{country.alpha2} country"
      # LU country lookup appears to match to Los Angeles
      lookup = country.name if country.alpha2 == 'LU'

      next unless (result = geocode(lookup))
      puts 'WARNING:: Geocoder returned something that was not a country' unless result.types.include?('country')
      geometry = result.geometry

      # Extract center point data
      if geometry['location']
        data[code]['geo']['latitude'] = geometry['location']['lat']
        data[code]['geo']['longitude'] = geometry['location']['lng']
      end

      # Extract bounding box data
      next unless geometry['bounds']
      data[code]['geo']['bounds'] = geometry['bounds']
      data[code]['geo']['min_latitude'] = geometry['bounds']['southwest']['lat']
      data[code]['geo']['min_longitude'] = geometry['bounds']['southwest']['lng']
      data[code]['geo']['max_latitude'] = geometry['bounds']['northeast']['lat']
      data[code]['geo']['max_longitude'] = geometry['bounds']['northeast']['lng']

      # Persist
      save_country_yaml(code, data)
    end
  end

  desc 'Retrieve and store subdivisions coordinates'
  task :fetch_subdivisions do
    require 'countries'
    # Iterate all countries with subdivisions
    ISO3166::Country.all.select(&:subdivisions?).each do |c|
      # Iterate subdivisions
      state_data = c.subdivisions.dup
      state_data.reject { |_, data| data['latitude'] }.each do |code, data|
        location = "#{data['name']}, #{c.name}"

        # Handle special geocoding cases where Google defaults to well known
        # cities, instead of the states.
        if c.alpha2 == 'US' && %w(NY WA OK).include?(code)
          location = "#{data['name']} State, United States"
        end

        next unless (result = geocode(location))
        geometry = result.geometry
        if geometry['location']
          state_data[code]['geo']['latitude'] = geometry['location']['lat']
          state_data[code]['geo']['longitude'] = geometry['location']['lng']
        end
        next unless geometry['bounds']
        state_data[code]['geo']['min_latitude'] = geometry['bounds']['southwest']['lat']
        state_data[code]['geo']['min_longitude'] = geometry['bounds']['southwest']['lng']
        state_data[code]['geo']['max_latitude'] = geometry['bounds']['northeast']['lat']
        state_data[code]['geo']['max_longitude'] = geometry['bounds']['northeast']['lng']
      end
      # Write updated YAML for current country
      File.open(File.join(ISO3166_ROOT_PATH, 'lib', 'countries', 'data', 'subdivisions', "#{c.alpha2}.yaml"), 'w+') { |f| f.write state_data.to_yaml }
    end
  end
end
