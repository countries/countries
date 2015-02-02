# -*- encoding: utf-8 -*-
require File.expand_path('../lib/countries/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Josh Robinson', 'Joe Corcoran']
  gem.email         = ['hexorx@gmail.com']
  gem.description   = 'All sorts of useful information about every country packaged as pretty little country objects. It includes data from ISO 3166'
  gem.summary       = 'Gives you a country object full of all sorts of useful information.'
  gem.homepage      = 'http://github.com/hexorx/countries'

  gem.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'countries'
  gem.require_paths = ['lib']
  gem.version       = Countries::VERSION

  gem.add_dependency('i18n_data', '~> 0.6.0')
  gem.add_dependency('currencies', '~> 0.4.2')
  gem.add_development_dependency('rspec', '>= 3')
  gem.add_development_dependency 'yard'
end
