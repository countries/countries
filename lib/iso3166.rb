require 'yaml'
require 'iso4217'
require 'i18n_data'

require 'countries/country'

if defined?(ActionView::Helpers::FormOptionsHelper)
  ActionView::Helpers::FormOptionsHelper::COUNTRIES = ISO3166::Country::Names.map { |(name, alpha2)| [name.html_safe, alpha2] }
end
