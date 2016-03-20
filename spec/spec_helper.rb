require 'countries'
RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding perf: true
  config.example_status_persistence_file_path = 'spec/examples.txt'

  config.warnings = true

  config.default_formatter = 'doc' if config.files_to_run.one?
  # config.order = :random
  # Kernel.srand config.seed
end
