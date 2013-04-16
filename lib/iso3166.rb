require 'yaml'
require 'iso4217'

require 'countries/country'

ActionView::Helpers::FormOptionsHelper::COUNTRIES = ISO3166::Country::Names.map{ |(name,alpha2)| [name.html_safe,alpha2] }
require 'country_select'
