Countries
=========

Countries is a collection of all sorts of useful information for every country in the ISO 3166 standard. It contains info for the following standards ISO3166-1(countries), ISO3166-2(states/subdivisions), ISO4217(currency) and E.164(phone numbers). I will add any country based data I can get access to. I hope this to be a repository for all country based information.

[![Build Status](https://travis-ci.org/hexorx/countries.svg)](https://travis-ci.org/hexorx/countries) [![Dependency Status](https://gemnasium.com/hexorx/countries.svg)](https://gemnasium.com/hexorx/countries) [![Code Climate](https://codeclimate.com/github/hexorx/countries.svg)](https://codeclimate.com/github/hexorx/countries) [![Waffle.io Issues in Ready](https://badge.waffle.io/hexorx/countries.svg)](http://waffle.io/hexorx/countries)

Installation
------------

    gem install countries

If you’re in Rails 2.3 or earlier, place this in your environment.rb:

    config.gem 'countries'

Or you can install via bundler Gemfile if you are using Rails 3:

    gem 'countries'

Or you can install via bundler Gemfile with a Country Helper class:

    gem 'countries', :require => 'countries/global'

Upgrading to 1.2.0
-----------

    gem 'countries', :require => 'global'

has become

    gem 'countries', :require => 'countries/global'


Basic Usage
-----------

Note that Country class still exist by default.
(is inherited from ISO3166::Country to keep backward compatibility).

Simply load a new country object using Country.new(*alpha2*) or the shortcut Country[*alpha2*]. An example works best.

    c = ISO3166::Country.new('US')

    # with global Country Helper
    c = Country['US']

Attribute-Based Finder Methods
------------

You can lookup a country or an array of countries using any of the data attributes via the find\_country\_by_*attribute* dynamic methods:

    c = ISO3166::Country.find_country_by_name('united states')
    list = ISO3166::Country.find_all_countries_by_region('Americas')
    c = ISO3166::Country.find_country_by_alpha3('can')

For a list of available attributes please see ISO3166::Country::AttrReaders.
Note: searches are *case insensitive*.

Country Info
------------

  Identification Codes

    c.number #=> "840"
    c.alpha2 #=> "US"
    c.alpha3 #=> "USA"
    c.gec    #=> "US"

  Names & Translations

    c.name #=> "United States"
    c.names #=> ["United States of America", "Vereinigte Staaten von Amerika", "États-Unis", "Estados Unidos"]

    # Get the names for a country translated to its local languages
    c = Country[:BE]
    c.local_names #=> ["België", "Belgique", "Belgien"]
    c.local_name #=> "België"

    # Get a specific translation
    c.translation('de') #=> 'Vereinigte Staaten von Amerika'
    c.translations['fr'] #=> "États-Unis"

    ISO3166::Country.translations             # {"DE"=>"Germany",...}
    ISO3166::Country.translations('DE')       # {"DE"=>"Deutschland",...}
    ISO3166::Country.all_translated           # ['Germany', ...]
    ISO3166::Country.all_translated('DE')     # ['Deutschland', ...]

  Subdivisions & States

    c.subdivisions #=> {"CO" => {"name" => "Colorado", "names" => "Colorado"}, ... }
    c.states #=> {"CO" => {"name" => "Colorado", "names" => "Colorado"}, ... }

  Location

    c.latitude #=> "38 00 N"
    c.longitude #=> "97 00 W"
    c.latitude_dec #=> 39.44325637817383
    c.longitude_dec #=> -98.95733642578125

    c.region #=> "Americas"
    c.subregion #=> "Northern America"

  Telephone Routing (E164)

    c.country_code #=> "1"
    c.national_destination_code_lengths #=> 3
    c.national_number_lengths #=> 10
    c.international_prefix #=> "011"
    c.national_prefix #=> "1"

  Boundry Boxes

    c.min_longitude #=> '45'
    c.min_latitude #=> '22.166667'
    c.max_longitude #=> '58'
    c.max_latitude #=> '26.133333'

  European Union Membership

    c.in_eu? #=> false

Currencies
----------

Countries now uses the [Currencies][] gem. What this means is you now get back a Currency object that gives you access to all the currency information. It acts the same as a hash so the same ['name'] methods still work.

    c.currency['code'] #=> 'USD'
    c.currency['name'] #=> 'Dollars'
    c.currency['symbol'] #=> '$'

Address Formatting
------------------

A template for formatting addresses is available through the address_format method. These templates are compatible with the [Liquid][] template system.

    c.address_format #=> "{{recipient}}\n{{street}}\n{{city}} {{region}} {{postalcode}}\n{{country}}"

Mongoid
-------

Mongoid support has been added. It is required automatically if Mongoid is defined in your project.

Use native country fields in your model:

    field :country, type: Country

Adds native support for searching/saving by a country object or alpha2 code.

Searching:

    # By alpha2
    british_things = Things.where(country: 'GB')
    british_things.first.country.name    # => "United Kingdom"

    # By object
    british_things = Things.where(country: Country.find_by_name('United Kingdom')[1])
    british_things.first.country.name    # => "United Kingdom"

Saving:

    # By alpha2
    british_thing = Thing.new(country: 'GB')
    british_thing.save!
    british_thing.country.name    # => "United Kingdom"

    # By object
    british_thing = Thing.new(country: Country.find_by_name('United Kingdom')[1])
    british_thing.save!
    british_thing.country.name    # => "United Kingdom"

Note that the database stores only the alpha2 code and rebuilds the object when queried. To return the country name by default you can override the reader method in your model:

    def country
        super.name
    end

ToDo
----

* State select
* Class methods for looking up information
* Default country
* Exclude countries
* Preferred countries
* Whitelist countries

Note on Patches/Pull Requests
-----------------------------

## Please do not submit pull requests on cache/translations.yaml
Any additions should be directed upstream to (pkg-isocodes)[http://anonscm.debian.org/cgit/pkg-isocodes/iso-codes.git/]

New Bugs can be filed upstream here https://alioth.debian.org/projects/pkg-iso-codes/

Any corrections can be applied in translations_corrections.yaml these will be injected during
the next ```rake update_cache```

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

Copyright (c) 2015 hexorx. See LICENSE for details.


[Teliax]: http://teliax.com
[Centrex]: http://en.wikipedia.org/wiki/Centrex
[CommonDataHub]: http://commondatahub.com
[Currencies]: http://gemcutter.org/gems/currencies
[Money]: http://gemcutter.org/gems/money
[Liquid]: http://www.liquidmarkup.org/
[country_select]: https://github.com/stefanpenner/country_select
