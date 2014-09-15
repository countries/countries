require 'yaml'
require 'iso4217'

require 'countries/country'

if defined?(ActionView::Helpers::FormOptionsHelper)
  Kerner.silence_warnings do
    ActionView::Helpers::FormOptionsHelper::COUNTRIES = ISO3166::Country::Names.map{ |(name,alpha2)| [name.html_safe,alpha2] }
  end
end
