# frozen_string_literal: true

source 'https://rubygems.org'
gem 'money'
gem 'rake'
gem 'tzinfo'

# Specify your gem's dependencies in countries.gemspec
gemspec

group :development, :test do
  gem 'benchmark' # no longer a default gem as of Ruby 4.0; used by spec/perf_spec.rb
  gem 'debug'
  gem 'yaml'
  gem 'memory_profiler' # spec/perf_spec.rb
  gem 'ruby-prof' # spec/perf_spec.rb
end
