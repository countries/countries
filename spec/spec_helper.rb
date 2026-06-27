# frozen_string_literal: true

# SimpleCov must start before the library is required, otherwise the
# already-loaded lib files are not instrumented
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'countries'
require 'debug'

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding perf: true
  config.example_status_persistence_file_path = 'spec/examples.txt'

  config.warnings = true

  config.default_formatter = 'doc' if config.files_to_run.one?
  # config.order = :random
  Kernel.srand config.seed

  config.register_ordering :global do |examples|
    defined, other = examples.partition do |example|
      example.metadata[:custom_order] == :first
    end

    randomized = RSpec::Core::Ordering::Random.new(config).order(other)

    defined + randomized
  end
end
