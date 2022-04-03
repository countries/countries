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
  require 'yaml'
  require 'i18n_data'

  codes = Dir['lib/countries/data/countries/*.yaml'].map { |x| File.basename(x, File.extname(x)) }.uniq.sort
  data = {}

  corrections_file = File.join(File.dirname(__FILE__), 'lib', 'countries', 'data', 'translation_corrections.yaml')
  corrections = YAML.load_file(corrections_file) || {}

  language_keys = I18nData.languages.keys + %w[zh_CN zh_TW zh_HK bn_IN pt_BR]
  # Ignore locales that have bad data in i18n_data 0.16.0
  language_keys -= %w[AY AM BA]
  language_keys.each do |locale|
    locale = locale.downcase
    begin
      local_names = I18nData.countries(locale)
    rescue I18nData::NoTranslationAvailable
      next
    end

    # Apply any known corrections to i18n_data
    corrections[locale]&.each do |alpha2, localized_name|
      local_names[alpha2] = localized_name
    end

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
