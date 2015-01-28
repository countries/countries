#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rake'
require 'rspec/core/rake_task'

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--color]
end

task :default => [:spec]

desc "Test and Clean YAML files"
task :clean_yaml do
  require 'yaml'

  d = Dir['**/*.yaml']
  d.each do |file|
    begin
      puts "checking : #{file}"
      data = YAML.load_file(file)
      File.open(file, 'w') {|f| f.write data.to_yaml }
    rescue Exception
      puts "failed to read #{file}: #{$!}"
    end
  end
end


# usage `rake fill_yaml[ru]`
desc 'Fill YAML with translations'
task :fill_yaml, [:language] do |t, args|
  require 'yaml'
  require 'countries'

  codes = Country.all.map { |c| c[1] }
  codes.each do |code|
    cfg = YAML.load_file("lib/data/countries/#{code}.yaml")
    unless cfg[code]['names'].include?(Country[code].translations[args.language.downcase])
      cfg[code]['names'] << Country[code].translations[args.language.downcase] 
    end
    File.open("lib/data/countries/#{code}.yaml", 'w') { |f| YAML.dump(cfg, f) }
  end  
end  