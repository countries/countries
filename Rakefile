#!/usr/bin/env rake
require 'bundler/gem_tasks'

require 'rake'
require 'rspec/core/rake_task'

desc 'Run all examples'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w(--color --warnings)
end

task default: [:spec]

desc 'Test and Clean YAML files'
task :clean_yaml do
  require 'yaml'

  d = Dir['**/*.yaml']
  d.each do |file|
    begin
      puts "checking : #{file}"
      data = YAML.load_file(file)
      File.open(file, 'w') { |f| f.write data.to_yaml }
    rescue
      puts "failed to read #{file}: #{$ERROR_INFO}"
    end
  end
end

desc 'Update Cache'
task :update_cache do
  require 'yaml'
  require 'i18n_data'

  codes = YAML.load_file(File.join(File.dirname(__FILE__), 'lib', 'countries', 'data', 'countries.yaml')) || {}
  data = {}
  empty_translations_hash = {}
  corrections = YAML.load_file(File.join(File.dirname(__FILE__), 'lib', 'countries', 'data', 'translation_corrections.yaml')) || {}

  I18nData.languages.keys.each do |locale|
    locale = locale.downcase
    begin
      local_names = I18nData.countries(locale)
    rescue I18nData::NoTranslationAvailable
      next
    end

    # Apply any known corrections to i18n_data
    unless corrections[locale].nil?
      corrections[locale].each do |alpha2, localized_name|
        local_names[alpha2] = localized_name
      end
    end

    codes.each do |alpha2|
      data[alpha2] ||= YAML.load_file(File.join(File.dirname(__FILE__), 'lib', 'countries', 'data', 'countries', "#{alpha2}.yaml"))[alpha2]
      data[alpha2]['translations'] ||= empty_translations_hash.dup
      data[alpha2]['translations'][locale] = local_names[alpha2]
      data[alpha2]['translated_names'] ||= []
      data[alpha2]['translated_names'] << local_names[alpha2]
      data[alpha2]['translated_names'] = data[alpha2]['translated_names'].uniq
    end
  end

  File.open(File.join(File.dirname(__FILE__), 'lib', 'countries', 'cache', 'countries'), 'wb') { |f| f.write(Marshal.dump(data)) }
end

require 'geocoder'
require 'retryable'
# raise on geocoding errors such as query limit exceeded
Geocoder.configure(always_raise: :all)
# Try to geocode a given query, on exceptions it retries up to 3 times then gives up.
# @param [String] query string to geocode
# @return [Hash] first valid result or nil
def geocode(query)
  Retryable.retryable(tries: 3, sleep: lambda { |n| 2**n }) do
    Geocoder.search(query).first
  end
rescue => e
  warn "Attempts exceeded for query #{query}, last error was #{e.message}"
  nil
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

      if (result = geocode(location))
        geometry = result.geometry
        if geometry['location']
          state_data[code]['latitude'] = geometry['location']['lat']
          state_data[code]['longitude'] = geometry['location']['lng']
        end
        if geometry['bounds']
          state_data[code]['min_latitude'] = geometry['bounds']['southwest']['lat']
          state_data[code]['min_longitude'] = geometry['bounds']['southwest']['lng']
          state_data[code]['max_latitude'] = geometry['bounds']['northeast']['lat']
          state_data[code]['max_longitude'] = geometry['bounds']['northeast']['lng']
        end
      end
    end
    # Write updated YAML for current country
    File.open(File.join(File.dirname(__FILE__), 'lib', 'data', 'subdivisions', "#{c.alpha2}.yaml"), 'w+') { |f| f.write state_data.to_yaml }
  end
end
