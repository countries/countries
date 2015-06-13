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

desc 'Cache Translations'
task :cache_translations do
  require 'yaml'
  require 'i18n_data'

  codes = YAML.load_file(File.join(File.dirname(__FILE__), 'lib', 'data', 'countries.yaml')) || {}
  data = {}
  empty_translations_hash = {}
  corrections = YAML.load_file(File.join(File.dirname(__FILE__), 'lib', 'data', 'translation_corrections.yaml')) || {}

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
      data[alpha2] ||= {}
      data[alpha2]['translations'] ||= empty_translations_hash.dup
      data[alpha2]['translations'][locale] = local_names[alpha2]
      data[alpha2]['translated_names'] ||= []
      data[alpha2]['translated_names'] << local_names[alpha2]
      data[alpha2]['translated_names'] = data[alpha2]['translated_names'].uniq
    end

  end

  File.open(File.join(File.dirname(__FILE__), 'lib', 'cache', 'translations.yaml'), 'w+') do |f|
    f.write "# PLEASE DO NOT ALTER THIS FILE, add pull requests to translation_corrections.yaml \n"
    f.write data.to_yaml
  end
end
