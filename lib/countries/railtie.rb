require 'countries'
require 'rails'
module Countries
  class Railtie < Rails::Railtie
    railtie_name :countries

    rake_tasks do
      load "tasks/countries.rake"
    end
  end
end
