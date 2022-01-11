# frozen_string_literal: true

require 'geocoder'
require 'retryable'

Geocoder.configure(
  lookup: :google,
  timeout: 10,
  api_key: GOOGLE_API_KEY
)

# raise on geocoding errors such as query limit exceeded
Geocoder.configure(always_raise: :all)
# Try to geocode a given query, on exceptions it retries up to 3 times then gives up.
# @param [String] query string to geocode
# @return [Hash] first valid result or nil
def geocode(query, params)
  Retryable.retryable(tries: 3, sleep: ->(n) { 2**n }) do
    Geocoder.search(query, params: params).first
  end
rescue Geocoder::Error, Geocoder::LookupTimeout => e
  warn "Attempts exceeded for query #{query}, last error was #{e.message}"
  nil
end

def load_country_yaml(alpha2)
  YAML.load_file(File.join(ISO3166_ROOT_PATH, 'lib', 'countries', 'data', 'countries', "#{alpha2}.yaml"))
end

def save_country_yaml(alpha2, data)
  File.write(File.join(ISO3166_ROOT_PATH, 'lib', 'countries', 'data', 'countries', "#{alpha2}.yaml"), data.to_yaml)
end

def country_codes
  @country_codes ||= Dir['lib/countries/data/countries/*.yaml'].map { |x| File.basename(x, File.extname(x)) }.uniq
end

namespace :geocode do
  desc 'Retrieve and store countries coordinates'
  task :fetch_countries do
    require 'countries'
    # Iterate over countries
    ISO3166::Country.all.each do |country|
      code = country.alpha2
      # Load unmutated yaml file.
      data = load_country_yaml(country.alpha2)

      next unless (result = geocode(country.iso_short_name, {region: country.alpha2}))

      unless result.types.include?('country')
        puts "WARNING:: Geocoder returned something that was not a country for #{country.alpha2}"
      end
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
    require_relative '../../countries'
    # Iterate all countries with subdivisions
    ISO3166::Country.all.select(&:subdivisions?).each do |c|
      # Iterate subdivisions
      state_data = c.subdivisions.dup
      state_data.reject { |_, data| data['geo'] }.each do |code, _|
        location = "#{c.alpha2}-#{code}"

        next unless (result = geocode(location, { region: c.alpha2 }))

        geometry = result.geometry
        if geometry['location']
          state_data[code]['geo'] ||= {}
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
      out = File.join(ISO3166_ROOT_PATH, 'lib', 'countries', 'data', 'subdivisions', "#{c.alpha2}.yaml")
      File.write(out, state_data.to_yaml)
    end
  end
end
