require 'countries'
RSpec.configure do |config|

  # config.after(:each) do
  #   ISO3166.reset
  # end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.example_status_persistence_file_path = "spec/examples.txt"

  config.warnings = true

  # if config.files_to_run.one?
  #   config.default_formatter = 'doc'
  # end

  # config.profile_examples = 10

  # config.order = :random

  # Kernel.srand config.seed

end
