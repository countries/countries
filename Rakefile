require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "countries"
    gem.summary = 'Gives you a country object full of all sorts of useful information.'
    gem.description = 'All sorts of useful information about every country packaged as pretty little country objects. It includes data from ISO 3166 (countries and subdivisions), ISO 4217 (currency), and E.164 (phone numbers). As a bonus it even adds a country_select helper to rails projects.'
    gem.email = "hexorx@gmail.com"
    gem.homepage = "http://github.com/hexorx/countries"
    gem.authors = ["hexorx"]
    gem.add_dependency('currencies', '>= 0.2.0')
    gem.add_development_dependency "rspec"
    gem.add_development_dependency "yard"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
