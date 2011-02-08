Countries
=========

Countries is a collection of all sorts of useful information for every country in the ISO 3166 standard. It contains info for the following standards ISO3166-1(countries), ISO3166-2(states/subdivisions), ISO4217(currency) and E.164(phone numbers). The gem also adds a country_select helper. I will add any country based data I can get access to. I hope this to be a repository for all country based information.

Warning!
--------

The data in this gem is collected from many different sources including [CommonDataHub][] and represents a best effort to be accurate and up to date. It is used at your own risk.

Installation
------------

Countries is hosted on GemCutter, so simply run the following:

    gem sources -a http://gemcutter.org
    sudo gem install countries

Or you can install via bundler Gemfile:

    gem 'countries'

Or you can install via bundler Gemfile with using only ISO3166::Country (no Country class):

    gem 'countries', :require => 'iso3166'

Country Select Helper
---------------------

As a bonus if you add the gem to a rails project it automatically gives you a country_select form helper. Unlike the normal country select it will store the alpha2 country code not the country name.
    
Basic Usage
-----------

Note that Country class still exist by default.
(is inherited from ISO3166::Country to keep backward compatibility).

Simply load a new country object using Country.new(*alpha2*) or the shortcut Country[*alpha2*]. An example  works best.

    c = Country.new('US')
    c = Country['US']
    
Country Info
------------

    c.number # ISO3166 numeric country code
    c.alpha2 # ISO3166 alpha2 country code
    c.alpha3 # ISO3166 alpha2 country code

    c.name # ISO3166 name
    c.names # ISO3166 alternate names

    c.latitude # uuuh the latitude
    c.longitude # obvious?

    c.region # UN Region
    c.subregion # UN SubRegion

    c.subdivisions # All ISO3166-2 for that country with there codes
    
Currencies
----------

Countries now uses the [Currencies][] gem. What this means is you now get back a Currency object that gives you access to all the currency information. It acts the same as a hash so the same ['name'] methods still work.

    c.currency['code'] => 'USD'
    c.currency['name'] => 'Dollars'
    c.currency['symbol'] => '$'

If a country has an alternate currency it can be accessed via the *alt_currency* method and will also return a Currency object.

Since we are using the [Currencies][] gem we get a bonus ExchangeBank that can be used with the [Money][] gem. It auto loads exchange rates from Yahoo Finance.

    Money.default_bank = Currency::ExchangeBank.new
    Money.us_dollar(100).exchange_to("CAD")  # => Money.new(124, "CAD")
    
Telephone Routing (E164)
------------------------

c.country_code # E.164 Country Code
c.national_destination_code_lengths # E.164 length of national destination code
c.national_number_lengths # E.164 length of the national number
c.international_prefix # E.164 code for dialing international from country
c.national_prefix # E164 code for dialing within the country

Address Formatting
------------------
    
A template for formatting addresses is available through the address_format method.

    c.address_format => "{{recipient}}\n{{street}}\n{{city}} {{region}} {{postalcode}}\n{{country}}"


ToDo
----

* more awesomer search/indexing
* use the e164 gem for telephone routing
* extract address_format into a separate gem
* make class for accessing subdivision info

Sponsored By
------------

This gem is sponsored by [Teliax][]. [Teliax][] makes business class Voice, [Centrex][](Including Hosted: IVRs, Ring Groups, Extensions and Day Night Mode) and Data services accessible to anyone. You don't have to be a fortune 500 to sound big!

Note on Patches/Pull Requests
-----------------------------
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but
   bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2009 hexorx. See LICENSE for details.


[Teliax]: http://teliax.com
[Centrex]: http://en.wikipedia.org/wiki/Centrex
[CommonDataHub]: http://commondatahub.com
[Currencies]: http://gemcutter.org/gems/currencies
[Money]: http://gemcutter.org/gems/money
