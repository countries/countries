#!/usr/bin/env rake
require 'bundler/gem_tasks'

require 'rake'
require 'rspec/core/rake_task'

ISO3166_ROOT_PATH = File.dirname(__FILE__)
Dir.glob('lib/countries/tasks/*.rake').each { |r| load r }

desc 'Run all examples'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--color --warnings]
end

task default: [:spec]

task :update_yaml_structure do
  require 'yaml'

  require 'pry'

  d = Dir['lib/countries/data/subdivisions/*.yaml']
  d.each do |file|
    puts "checking : #{file}"
    data = YAML.load_file(file)

    data = data.each_with_object({}) do |(k, subd), a|
      a[k] ||= {}
      a[k]['unofficial_names'] = subd.delete('names')
      a[k]['translations'] = { 'en' => subd['name'] }
      a[k]['geo'] = {
        'latitude' => subd.delete('latitude'),
        'longitude' => subd.delete('longitude'),
        'min_latitude' => subd.delete('min_latitude'),
        'min_longitude' => subd.delete('min_longitude'),
        'max_latitude' => subd.delete('max_latitude'),
        'max_longitude' => subd.delete('max_longitude')
      }

      a[k] = a[k].merge(subd)
    end
    File.open(file, 'w') { |f| f.write data.to_yaml }
    begin
  rescue
    puts "failed to read #{file}: #{$ERROR_INFO}"
  end
  end
end

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

  codes = Dir['lib/countries/data/countries/*.yaml'].map { |x| File.basename(x, File.extname(x)) }.uniq
  data = {}

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

    File.open(File.join(File.dirname(__FILE__), 'lib', 'countries', 'cache', 'locales', "#{locale}.json"), 'wb') { |f| f.write(local_names.to_json) }
  end

  codes.each do |alpha2|
    data[alpha2] ||= YAML.load_file(File.join(File.dirname(__FILE__), 'lib', 'countries', 'data', 'countries', "#{alpha2}.yaml"))[alpha2]
  end

  File.open(File.join(File.dirname(__FILE__), 'lib', 'countries', 'cache', 'countries.json'), 'wb') { |f| f.write(data.to_json) }
end
