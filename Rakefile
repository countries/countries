#!/usr/bin/env rake
require 'bundler/gem_tasks'

require 'rake'
require 'rspec/core/rake_task'

desc 'Run all examples'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w(--color)
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
