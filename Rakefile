#!/usr/bin/env rake
# frozen_string_literal: true

require 'bundler/gem_tasks'

require 'rake'
require 'rspec/core/rake_task'
require 'yaml'

ISO3166_ROOT_PATH = File.dirname(__FILE__)

# Enter your API Key enabled for Geocoding API and Places API
GOOGLE_API_KEY = 'ENTER API KEY'

Dir.glob('lib/countries/tasks/*.rake').each { |r| load r }

desc 'Run all examples'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--color --warnings]
end

task default: [:spec]

desc 'Update CLDR subdivison data set'
task :update_cldr_subdivison_data do
  require_relative './lib/countries/sources'
  Sources::CLDR::Downloader.subdivisions
  Sources::CLDR::SubdivisionUpdater.new.call
end

desc 'Update Cache'
task :update_cache do
  codes = Dir['lib/countries/data/countries/*.yaml'].map { |x| File.basename(x, File.extname(x)) }.uniq.sort
  data = {}

  Dir['lib/countries/data/translations/countries-*.yaml'].each do |locale_file|
    locale = locale_file.split('-').last.split('.').first.downcase
    local_names = YAML.load_file(locale_file)

    out = File.join(File.dirname(__FILE__), 'lib', 'countries', 'cache', 'locales', "#{locale.gsub(/_/, '-')}.json")
    File.binwrite(out, local_names.to_json)
  end

  codes.each do |alpha2|
    country_file = File.join(File.dirname(__FILE__), 'lib', 'countries', 'data', 'countries', "#{alpha2}.yaml")
    data[alpha2] ||= YAML.load_file(country_file)[alpha2]
  end

  out_file = File.join(File.dirname(__FILE__), 'lib', 'countries', 'cache', 'countries.json')
  File.binwrite(out_file, data.to_json)
end

desc 'Sort subdivision YAML by code and translations by locale'
task :cleanup_subdivision_yaml do
  ISO3166::Country.codes.each do |c_code|
    sd = Sources::Local::Subdivision.new(c_code)
    data = sd.load
    next if data.nil? || data == {}
    data = data.sort.to_h
    data['translations'] = data['translations'].sort.to_h unless data['translations'].nil?
    sd.save(data)
  end
end
