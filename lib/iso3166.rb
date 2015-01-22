require 'yaml'
require 'iso4217'

require 'countries/country'

if defined?(ActionView::Helpers::FormOptionsHelper)
  unless defined? ActionView::Helpers::FormOptionsHelper::COUNTRIES
    ActionView::Helpers::FormOptionsHelper::COUNTRIES = ISO3166::Country::Names.map{ |(name,alpha2)| [name.html_safe,alpha2] }
  end
end
