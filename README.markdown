Countries
=========

Countries is a collection of all sorts of useful information for every country in the ISO 3166 standard. It contains info for the following standards ISO3166-1(countries), ISO3166-2(states/subdivisions), ISO4217(currency) and E.164(phone numbers). I will add any country based data I can get access to. I hope this to be a repository for all country based information.

[![Codewake](https://www.codewake.com/badges/ask_question_flat_square.svg)](https://www.codewake.com/p/countries) [![Gem Version](https://badge.fury.io/rb/countries.svg)](https://badge.fury.io/rb/countries) [![Build Status](https://travis-ci.org/hexorx/countries.svg)](https://travis-ci.org/hexorx/countries) [![Dependency Status](https://gemnasium.com/hexorx/countries.svg)](https://gemnasium.com/hexorx/countries) [![Code Climate](https://codeclimate.com/github/hexorx/countries.svg)](https://codeclimate.com/github/hexorx/countries)

Installation
------------

``` bash
    gem install countries
```

If you’re in Rails 2.3 or earlier, place this in your environment.rb:

``` ruby
    config.gem 'countries'
```

Or you can install via bundler Gemfile if you are using Rails 3/4/5:

    gem 'countries'

Basic Usage
-----------

Simply load a new country object using Country.new(*alpha2*) or the shortcut Country[*alpha2*]. An example works best.

``` ruby
c = ISO3166::Country.new('US')
```

Configuration
-----------

#### Country Helper
Some apps might not want to constantly call `ISO3166::Country` this gem has a
helper that can provide a `Country` class

``` ruby
# with global Country Helper
c = Country['US']
```

**This will conflict with any existing `Country` constant**

To Use

``` ruby
gem 'countries', :require => 'countries/global'
```

##### Upgrading Country Helper to > 1.2.0
``` ruby
gem 'countries', :require => 'global'
```

has become
``` ruby
gem 'countries', :require => 'countries/global'
```

Selective Loading of Locales
------------

As of 2.0 you can selectively load locales to reduce memory usage in production.

By default we load I18n.available_locales if I18n is present, otherwise only [:en]. This means almost any rails environment will only bring in it's supported translations.

You can add all the locales like this.

``` ruby
ISO3166.configure do |config|
  config.locales = [:af, :am, :ar, :as, :az, :be, :bg, :bn, :br, :bs, :ca, :cs, :cy, :da, :de, :dz, :el, :en, :eo, :es, :et, :eu, :fa, :fi, :fo, :fr, :ga, :gl, :gu, :he, :hi, :hr, :hu, :hy, :ia, :id, :is, :it, :ja, :ka, :kk, :km, :kn, :ko, :ku, :lt, :lv, :mi, :mk, :ml, :mn, :mr, :ms, :mt, :nb, :ne, :nl, :nn, :oc, :or, :pa, :pl, :ps, :pt, :ro, :ru, :rw, :si, :sk, :sl, :so, :sq, :sr, :sv, :sw, :ta, :te, :th, :ti, :tk, :tl, :tr, :tt, :ug, :uk, :ve, :vi, :wa, :wo, :xh, :zh, :zu]
end
```

or something a bit more simple
``` ruby
ISO3166.configure do |config|
  config.locales = [:en, :de, :fr, :es]
end
```

Attribute-Based Finder Methods
------------

You can lookup a country or an array of countries using any of the data attributes via the find\_country\_by_*attribute* dynamic methods:

``` ruby
c = ISO3166::Country.find_country_by_name('united states')
list = ISO3166::Country.find_all_countries_by_region('Americas')
c = ISO3166::Country.find_country_by_alpha3('can')
```

For a list of available attributes please see ISO3166::DEFAULT_COUNTRY_HASH.
Note: searches are *case insensitive and ignore accents*.

Country Info
------------

  Identification Codes

    c.number #=> "840"
    c.alpha2 #=> "US"
    c.alpha3 #=> "USA"
    c.gec    #=> "US"

  Names & Translations

    c.name #=> "United States"
    c.unofficial_names #=> ["United States of America", "Vereinigte Staaten von Amerika", "États-Unis", "Estados Unidos"]

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

``` ruby
c.subdivisions #=> {"CO" => {"name" => "Colorado", "names" => "Colorado"}, ... }
c.states #=> {"CO" => {"name" => "Colorado", "names" => "Colorado"}, ... }
```
  Location

``` ruby
c.latitude #=> "38 00 N"
c.longitude #=> "97 00 W"
c.latitude_dec #=> 39.44325637817383
c.longitude_dec #=> -98.95733642578125

c.region #=> "Americas"
c.subregion #=> "Northern America"
```

Timezones **(optional)**

Add tzinfo to your gemfile, ensure it's required, Countries will not do this for you.

    gem 'tzinfo', '~> 1.2', '>= 1.2.2'

``` ruby
c.timezones.zone_identifiers #=> ["America/New_York", "America/Detroit", "America/Kentucky/Louisville", ...]
c.timezones.zone_info  # see [tzinfo docs]( http://www.rubydoc.info/gems/tzinfo/TZInfo/CountryInfo)
c.timezones # see [tzinfo docs]( http://www.rubydoc.info/gems/tzinfo/TZInfo/Country)
```

Telephone Routing (E164)

``` ruby
c.country_code #=> "1"
c.national_destination_code_lengths #=> 3
c.national_number_lengths #=> 10
c.international_prefix #=> "011"
c.national_prefix #=> "1"
```

Boundary Boxes

``` ruby
c.min_longitude #=> '45'
c.min_latitude #=> '22.166667'
c.max_longitude #=> '58'
c.max_latitude #=> '26.133333'
```

European Union Membership

``` ruby
c.in_eu? #=> false
```

Currencies
----------

**WARNING** if you have a top level class named `Money` you will conflict with this gem.  If this is a large issue we will add a feature to turn currency features off.

Countries now uses the [Money](https://github.com/RubyMoney/money) gem. What this means is you now get back a Money::Currency object that gives you access to all the currency information.

``` ruby
c.currency.code #=> 'USD'
c.currency.name #=> 'Dollars'
c.currency.symbol #=> '$'
```

Address Formatting
------------------

A template for formatting addresses is available through the address_format method. These templates are compatible with the [Liquid][] template system.

``` ruby
c.address_format #=> "{{recipient}}\n{{street}}\n{{city}} {{region}} {{postalcode}}\n{{country}}"
```

Loading Custom Data
-------
As of 2.0 countries supports loading custom countries / overriding data in it's data set, though if you choose to do this please contribute back to the upstream repo!

Any country registered this way will have it's data available for searching etc... If you are overriding an existing country, for cultural reasons, our code uses a simple merge, not a deep merge so you will need to __bring in all data you wish to be available__.  Bringing in an existing country will also remove it from the internal management of translations, __all registered countries will remain in memory__.

``` ruby
ISO3166::Data.register(
  alpha2: "LOL",
  name: 'Happy Country',
  translations: {
    'en' => "Happy Country",
    'de' => "glückliches Land"
  }
)

ISO3166::Country.new('LOL').name == 'Happy Country'
```

Mongoid
-------

Mongoid support has been added. It is required automatically if Mongoid is defined in your project.

Use native country fields in your model:

    field :country, type: Country

Adds native support for searching/saving by a country object or alpha2 code.

Searching:

```ruby
# By alpha2
british_things = Things.where(country: 'GB')
british_things.first.country.name    # => "United Kingdom"

# By object
british_things = Things.where(country: Country.find_by_name('United Kingdom')[1])
british_things.first.country.name    # => "United Kingdom"
```
Saving:

```ruby
# By alpha2
british_thing = Thing.new(country: 'GB')
british_thing.save!
british_thing.country.name    # => "United Kingdom"

# By object
british_thing = Thing.new(country: Country.find_by_name('United Kingdom')[1])
british_thing.save!
british_thing.country.name    # => "United Kingdom"
```

Note that the database stores only the alpha2 code and rebuilds the object when queried. To return the country name by default you can override the reader method in your model:

``` ruby
def country
    super.name
end
```

Country Code in Emoji
----------
``` ruby
c = Country['MY']
c.emoji_flag # => "🇺🇸"
```

Note on Patches/Pull Requests
-----------------------------

## Please do not submit pull requests on cache/**/*
Any additions should be directed upstream to [pkg-isocodes](http://anonscm.debian.org/cgit/pkg-isocodes/iso-codes.git/)

New Bugs can be filed upstream here https://alioth.debian.org/projects/pkg-iso-codes/
If you need to correct an upstream translation please add it to the lib/countries/data/translations_corrections.yaml

```
# Ex:
#
# locale:
#   alpha2: localized_name
#
```

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

Copyright (c) 2016 hexorx. See LICENSE for details.


[Teliax]: http://teliax.com
[Centrex]: http://en.wikipedia.org/wiki/Centrex
[CommonDataHub]: http://commondatahub.com
[Currencies]: http://gemcutter.org/gems/currencies
[Money]: http://gemcutter.org/gems/money
[Liquid]: http://www.liquidmarkup.org/
[country_select]: https://github.com/stefanpenner/country_select
