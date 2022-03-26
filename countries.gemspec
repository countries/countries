# frozen_string_literal: true

require File.expand_path('lib/countries/version', __dir__)

Gem::Specification.new do |gem|
  gem.authors       = ['Josh Robinson', 'Joe Corcoran', 'Russell Osborne', 'Pedro Moreira']
  gem.email         = ['hexorx@gmail.com', 'russell@burningpony.com', 'pedro@codecreations.tech']
  gem.description   = 'All sorts of useful information about every country packaged as pretty little country objects. It includes data from ISO 3166'
  gem.summary       = 'Gives you a country object full of all sorts of useful information.'
  gem.homepage      = 'https://github.com/countries/countries'
  gem.metadata      = { 'bug_tracker_uri' => 'https://github.com/countries/countries/issues',
                        'changelog_uri' => 'https://github.com/countries/countries/blob/master/CHANGELOG.md',
                        'source_code_uri' => 'https://github.com/countries/countries',
                        'wiki_uri' => 'https://github.com/countries/countries/wiki',
                        'rubygems_mfa_required' => 'true' }

  gem.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'countries'
  gem.require_paths = ['lib']
  gem.version       = Countries::VERSION.dup
  gem.license       = 'MIT'

  gem.required_ruby_version = '>= 2.7'

  gem.add_dependency('i18n_data', '~> 0.16.0')
  gem.add_dependency('sixarm_ruby_unaccent', '~> 1.1')
  gem.add_development_dependency('activesupport', '>= 3')
  gem.add_development_dependency('nokogiri', '>= 1.8')
  gem.add_development_dependency('rspec', '>= 3')
end
