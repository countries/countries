Countries
=========

Countries is a collection of all sorts of useful information for every country in the ISO 3166 standard. It contains info for the following standards ISO3166-1(countries), ISO3166-2(states/subdivisions), ISO4217(currency) and E.164(phone numbers). The gem also adds a country_select helper. I will add any country based data I can get access to. I hope this to be a repository for all country based information.

Installation
------------

    gem install countries
    
If you’re in Rails 2.3 or earlier, place this in your environment.rb:

    config.gem 'countries'
    
Or you can install via bundler Gemfile if you are using Rails 3:

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

  Identification Codes
  
    c.number #=> "840"
    c.alpha2 #=> "US"
    c.alpha3 #=> "USA"

  Names
  
    c.name #=> "United States"
    c.names #=> ["United States of America", "Vereinigte Staaten von Amerika", "États-Unis", "Estados Unidos"]
    
  Subdivisions & States
  
    c.subdivisions #=> {"CO" => {:name => "Colorado", :names => "Colorado"}, ... }
    c.states #=> {"CO" => {:name => "Colorado", :names => "Colorado"}, ... }

  Location
  
    c.latitude #=> "38 00 N"
    c.longitude #=> "97 00 W"

    c.region #=> "Americas"
    c.subregion #=> "Northern America"
  
  Telephone Routing (E164)
  
    c.country_code #=> "1"
    c.national_destination_code_lengths #=> 3
    c.national_number_lengths #=> 10
    c.international_prefix #=> "011"
    c.national_prefix #=> "1"
    
Currencies
----------

Countries now uses the [Currencies][] gem. What this means is you now get back a Currency object that gives you access to all the currency information. It acts the same as a hash so the same ['name'] methods still work.

    c.currency['code'] #=> 'USD'
    c.currency['name'] #=> 'Dollars'
    c.currency['symbol'] #=> '$'

If a country has an alternate currency it can be accessed via the *alt_currency* method and will also return a Currency object.

Since we are using the [Currencies][] gem we get a bonus ExchangeBank that can be used with the [Money][] gem. It auto loads exchange rates from Yahoo Finance.

    Money.default_bank = Currency::ExchangeBank.new
    Money.us_dollar(100).exchange_to("CAD")  # => Money.new(124, "CAD")

Address Formatting
------------------
    
A template for formatting addresses is available through the address_format method. These templates are compatible with the [Liquid][] template system.

    c.address_format #=> "{{recipient}}\n{{street}}\n{{city}} {{region}} {{postalcode}}\n{{country}}"


ToDo
----

* Mongoid support
* State select
* Class methods for looking up information
* Default country
* Exclude countries
* Preferred countries
* Whitelist countries

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

Copyright (c) 2011 hexorx. See LICENSE for details.


Cities
------

This product includes data created by MaxMind, available from [MaxMind][].
Copyright (c) 2008 MaxMind Inc.  All rights reserved.


[Teliax]: http://teliax.com
[Centrex]: http://en.wikipedia.org/wiki/Centrex
[CommonDataHub]: http://commondatahub.com
[Currencies]: http://gemcutter.org/gems/currencies
[Money]: http://gemcutter.org/gems/money
[Liquid]: http://www.liquidmarkup.org/
[MaxMind]: http://www.maxmind.com/app/worldcities
