# -*- encoding: utf-8 -*-
require File.expand_path('../lib/countries/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Josh Robinson', 'Joe Corcoran', 'Russell Osborne']
  gem.email         = ['hexorx@gmail.com', 'russell@burningpony.com']
  gem.description   = 'All sorts of useful information about every country packaged as pretty little country objects. It includes data from ISO 3166'
  gem.summary       = 'Gives you a country object full of all sorts of useful information.'
  gem.homepage      = 'http://github.com/hexorx/countries'

  gem.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'countries'
  gem.require_paths = ['lib']
  gem.version       = Countries::VERSION.dup
  gem.license       = 'MIT'

  gem.add_dependency('i18n_data', '~> 0.10.0')
  gem.add_dependency('unicode_utils', '~> 1.4')
  gem.add_dependency('sixarm_ruby_unaccent', '~> 1.1')
  gem.add_development_dependency('rspec', '>= 3')
  gem.add_development_dependency('activesupport', '>= 3')
  gem.add_development_dependency('nokogiri', '>= 1.8')
end
