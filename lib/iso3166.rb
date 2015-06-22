require 'yaml'
require 'iso4217'
require 'i18n_data'

require 'countries/setup'
require 'countries/country'

if defined?(ActionView::Helpers::FormOptionsHelper)
  ActionView::Helpers::FormOptionsHelper::COUNTRIES = ISO3166::Country.all_names_with_codes
end
