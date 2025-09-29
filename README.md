# Countries

Countries is a collection of all sorts of useful information for every country in the ISO 3166 standard. It contains info for the following standards ISO3166-1 (countries), ISO3166-2 (states/subdivisions), ISO4217 (currency) and E.164 (phone numbers).

The data used in this gem is also available as git submodules in [YAML](https://github.com/countries/countries-data-yaml) and [JSON](https://github.com/countries/countries-data-json) files.

[![Gem Version](https://badge.fury.io/rb/countries.svg)](https://badge.fury.io/rb/countries) [![Tests](https://github.com/countries/countries/actions/workflows/tests.yml/badge.svg)](https://github.com/countries/countries/actions/workflows/tests.yml)
 [![CodeQL](https://github.com/countries/countries/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/countries/countries/actions/workflows/codeql-analysis.yml)


## Installation

```bash
 gem install countries
 ```

 Or you can install via Bundler if you are using Rails:

```bash
bundle add countries
```

## Basic Usage

Simply load a new country object using Country.new(*alpha2*) or the shortcut Country[*alpha2*]. An example works best.

```ruby
c = ISO3166::Country.new('US')
```

Get all country codes (*alpha2*).

```ruby
ISO3166::Country.codes
#  ["TJ", "JM", "HT",...]
```

## Configuration

### Country Helper

Some apps might not want to constantly call `ISO3166::Country` this gem has a
helper that can provide a `Country` class

```ruby
# With global Country Helper
c = Country['US']
```

**This will conflict with any existing `Country` constant**

To Use

```ruby
gem 'countries', require: 'countries/global'
```

## Upgrading to 4.2 and 5.x

Release 4.2.0 introduced changes to name attributes and finders and deprecated several methods to resolve some existing confusion regardign official ISO country names vs. the "common names" that are commonly used.

The 5.0 release removed these deprecated methods and also removed support for Ruby 2.5 and 2.6

Please see [UPGRADE.md](../master/UPGRADE.md) for more information

## Attribute-Based Finder Methods

You can lookup a country or an array of countries using any of the data attributes via the find\_country\_by_*attribute* dynamic methods:

```ruby
c    = ISO3166::Country.find_country_by_iso_short_name('italy')
c    = ISO3166::Country.find_country_by_any_name('united states')
h    = ISO3166::Country.find_all_by(:translated_names, 'França')
list = ISO3166::Country.find_all_countries_by_region('Americas')
c    = ISO3166::Country.find_country_by_alpha2("FR")
```

For a list of available attributes please see `ISO3166::DEFAULT_COUNTRY_HASH`.
Note: searches are *case insensitive and ignore accents*.

_Please note that `find_by_name`, `find_by_names`, `find_*_by_name` and `find_*_by_names`  methods were removed in 5.0. See [UPGRADE.md](../master/UPGRADE.md) for more information_

## Country Info

### Identification Codes

```ruby
c.number # => "840"
c.alpha2 # => "US"
c.alpha3 # => "USA"
c.gec    # => "US"
```

### Names & Translations

```ruby
c.iso_long_name # => "The United States of America"
c.iso_short_name # => "United States of America"
c.iso_short_name_lower_case # => "United States of America (the)"
c.common_name # => "United States" (This is a shortcut for c.translations('en'))
c.unofficial_names # => ["United States of America", "Vereinigte Staaten von Amerika", "États-Unis", "Estados Unidos"]

# Get the names for a country translated to its local languages
c = ISO3166::Country[:BE]
c.local_names # => ["België", "Belgique", "Belgien"]
c.local_name # => "België"

# Get a specific translation
# `translation` method works with string or symbol locales
c.translation('de') # => 'Vereinigte Staaten von Amerika'
c.translation(:de) # => 'Vereinigte Staaten von Amerika'
# `translations` method returns a symbol-keyed hash of translations
c.translations[:fr] # => "États-Unis"

# Get all translations for a locale, defaults to 'en'
ISO3166::Country.translations         # {"de:"Germany",...}
ISO3166::Country.translations('de')   # {"DE"=>"Deutschland",...}
ISO3166::Country.all_translated       # ['Germany', ...]
q # ['Deutschland', ...]

# Nationality
c.nationality # => "American"
```

### Subdivisions & States

```ruby
c.subdivisions # => {"CO" => {"name" => "Colorado", "names" => "Colorado"}, ... }
c.subdivision_types # => ["state", "outlying_area", "district"]
c.subdivisions_of_types(['state']) # => {"CO" => {"name" => "Colorado", "names" => "Colorado"}, ... }
c.humanized_subdivision_types # => ["State", "Outlying area", "District"]

# This is now deprecated. #states is an alias of #subdivisions and returns all subdivisions regardless of type
c.states # => {"CO" => {"name" => "Colorado", "names" => "Colorado"}, ... }


# Get specific translations for the country subdivisions
c.subdivision_names_with_codes('es') #=> [ ..., ["Nuevo Hampshire", "NH"], ["Nueva Jersey", "NJ"], ... ]

# Subdivision code with translations for all loaded locales
c.subdivisions['NY'].code_with_translations #=> {"NY"=>{"en"=>"New York"}, ...}
```

`#find_subdivision_by_name` Find a country's state using its code or name in any translation

```ruby
> ISO3166::Country.new("IT").find_subdivision_by_name("Toscana").geo
 => {"latitude"=>43.771389, "longitude"=>11.254167, ... }
> ISO3166::Country.new("IT").find_subdivision_by_name("Tuscany").geo
 => {"latitude"=>43.771389, "longitude"=>11.254167, ... }
```

### Location

```ruby
c.latitude # => "37.09024"
c.longitude # => "-95.712891"

c.world_region # => "AMER"
c.region # => "Americas"
c.subregion # => "Northern America"
```

Please note that `latitude_dec` and `longitude_dec` were deprecated on release 4.2 and removed in 5.0. These attributes have been redundant for several years, since the `latitude` and `longitude` fields have been switched decimal coordinates.

### Timezones **(optional)**

Add `tzinfo` to your Gemfile and ensure it's required, Countries will not do this for you.

```ruby
gem 'tzinfo', '~> 1.2', '>= 1.2.2'
```

```ruby
c.timezones.zone_identifiers # => ["America/New_York", "America/Detroit", "America/Kentucky/Louisville", ...]
c.timezones.zone_info  # see [tzinfo docs](https://www.rubydoc.info/gems/tzinfo/TZInfo/CountryTimezone)
c.timezones # see [tzinfo docs](https://www.rubydoc.info/gems/tzinfo/TZInfo/Country)
```

### Telephone Routing (E164)

```ruby
c.country_code # => "1"
c.national_destination_code_lengths # => 3
c.national_number_lengths # => 10
c.international_prefix # => "011"
c.national_prefix # => "1"
```

### Boundary Boxes

```ruby
c.min_longitude # => '45'
c.min_latitude # => '22.166667'
c.max_longitude # => '58'
c.max_latitude # => '26.133333'

c.bounds #> {"northeast"=>{"lat"=>22.166667, "lng"=>58}, "southwest"=>{"lat"=>26.133333, "lng"=>45}}
```

### European Union Membership

```ruby
c.in_eu? # => false
```

### European Economic Area Membership

```ruby
c.in_eea? # => false
```

### European Single Market Membership

```ruby
c.in_esm? # => false
```

### EU VAT Area membership

```ruby
c.in_eu_vat? # => false
```

### UN membership

```ruby
c.in_un? # false
```

### GDPR Compliant (European Economic Area Membership or UK)

```ruby
c.gdpr_compliant? # => false
```

### Country Code in Emoji

```ruby
c = Country['MY']
c.emoji_flag # => "🇲🇾"
```

### Country Distance Unit (miles/kilometres)

```ruby
c.distance_unit # => "MI"
```

### Country Vehicle Registration Code

```ruby
c.vehicle_registration_code # => "D"
```

### Plucking multiple attributes

```ruby
ISO3166::Country.pluck(:alpha2, :iso_short_name) # => [["AD", "Andorra"], ["AE", "United Arab Emirates"], ...
```

`.collect_countries_with` allows to collect various countries' information using any valid method and query value:
```ruby
> ISO3166::Country.collect_countries_with("VR",:subdivisions,:common_name)
 => ["Italy", "Monaco"]
> ISO3166::Country.collect_countries_with("Caribbean",:subregion,:languages_spoken).flatten.uniq
 => ["en", "fr", "es", "ht", "nl"]
> ISO3166::Country.collect_countries_with("Oceania",:region,:international_prefix).uniq
 => ["00", "011", "0011", "19", "05"]
> ISO3166::Country.collect_countries_with("Antarctica",:continent,:emoji_flag)
 => ["🇦🇶", "🇬🇸", "🇧🇻", "🇹🇫", "🇭🇲"]
> ISO3166::Country.collect_countries_with("🇸🇨",:emoji_flag,:common_name)
 => ["Seychelles"]
```

`.collect_likely_countries_by_subdivision_name` allows to lookup all countries having the given state code or state name (in any translation)

```ruby
ISO3166::Country.collect_likely_countries_by_subdivision_name("San José",:common_name)
 => ["Costa Rica", "Uruguay"]
```

### Conversions

```ruby
ISO3166::Country.from_alpha3_to_alpha2('USA') # => "US"
ISO3166::Country.from_alpha2_to_alpha3('US') # => "USA"

ISO3166::Country.from_alpha2_to_alpha3('--') # => nil
```

## Currencies

To enable currencies extension please add the following to countries initializer.

```ruby
ISO3166.configuration.enable_currency_extension!
```

Please note that it requires you to add "money" dependency to your gemfile.

```ruby
gem "money", "~> 6.9"
```

Countries now uses the [Money](https://github.com/RubyMoney/money) gem. What this means is you now get back a `Money::Currency` object that gives you access to all the currency information.

```ruby
c = ISO3166::Country['us']
c.currency.iso_code # => 'USD'
c.currency.name # => 'United States Dollar'
c.currency.symbol # => '$'
```

## Address Formatting

A template for formatting addresses is available through the address_format method. These templates are compatible with the [Liquid](https://shopify.github.io/liquid/) template system.

```ruby
c.address_format # => "{{recipient}}\n{{street}}\n{{city}} {{region}} {{postalcode}}\n{{country}}"
```

## Selective Loading of Locales

As of 2.0 you can selectively load locales to reduce memory usage in production.

By default we load `I18n.available_locales` if I18n is present, otherwise only `[:en]`. This means almost any Rails environment will only bring in its supported translations.

You can add all the locales like this.

```ruby
ISO3166.configure do |config|
  config.locales = [:af, :am, :ar, :as, :az, :be, :bg, :bn, :br, :bs, :ca, :cs, :cy, :da, :de, :dz, :el, :en, :eo, :es, :et, :eu, :fa, :fi, :fo, :fr, :ga, :gl, :gu, :he, :hi, :hr, :hu, :hy, :ia, :id, :is, :it, :ja, :ka, :kk, :km, :kn, :ko, :ku, :lt, :lv, :mi, :mk, :ml, :mn, :mr, :ms, :mt, :nb, :ne, :nl, :nn, :oc, :or, :pa, :pl, :ps, :pt, :"pt-BR", :ro, :ru, :rw, :si, :sk, :sl, :so, :sq, :sr, :sv, :sw, :ta, :te, :th, :ti, :tk, :tl, :tr, :tt, :ug, :uk, :ve, :vi, :wa, :wo, :xh, :"zh-cn", :"zh-tw", :zu]
end
```

or something a bit more simple
```ruby
ISO3166.configure do |config|
  config.locales = [:en, :de, :fr, :es]
end
```

If you change the value of `ISO3166.configuration.locales` after initialization, you should call `ISO3166::Data.reset` to reset the data cache, or you may end up with inconsistently loaded locales.
As of 5.1.1, subdivision translations also respect this and will only load the selected locales.

## Loading Custom Data

As of 2.0 countries supports loading custom countries / overriding data in its data set, though if you choose to do this please contribute back to the upstream repo!

Any country registered this way will have its data available for searching etc... If you are overriding an existing country, for cultural reasons, our code uses a simple merge, not a deep merge so you will need to __bring in all data you wish to be available__.  Bringing in an existing country will also remove it from the internal management of translations, __all registered countries will remain in memory__.

```ruby
ISO3166::Data.register(
  alpha2: 'LOL',
  iso_short_name: 'Happy Country',
  translations: {  # Can use string or symbol keys
    'en' => 'Happy Country',
    'de' => 'glückliches Land'
  }
)

ISO3166::Country.new('LOL').iso_short_name == 'Happy Country'
```

## Mongoid

Mongoid support has been added. It is required automatically if Mongoid is defined in your project.

Use native country fields in your model:

```ruby
field :country, type: Country
```

Adds native support for searching/saving by a country object or alpha2 code.

Searching:

```ruby
# By alpha2
spanish_things = Things.where(country: 'ES')
spanish_things.first.country.iso_short_name    # => "Spain"

# By object
spanish_things = Things.where(country: Country.find_by_iso_short_name('Spain')[1])
spanish_things.first.country.iso_short_name    # => "Spain"
```

Saving:

```ruby
# By alpha2
spanish_things = Thing.new(country: 'ES')
spanish_things.save!
spanish_things.country.iso_short_name    # => "Spain"

# By object
spanish_things = Thing.new(country: Country.find_by_iso_short_name('Spain')[1])
spanish_things.save!
spanish_things.country.iso_short_name    # => "Spain"
```

Note that the database stores only the alpha2 code and rebuilds the object when queried. To return the country name by default you can override the reader method in your model:

```ruby
def country
  super.iso_short_name
end
```

## Note on Patches/Pull Requests

**Please do not submit pull requests on `cache/**/*`**. These files generated by a rake task when preparing new releases and are not meant to be manually updated.

If you with to submit a PR to update or correct country data, please edit the corresponding YAML file `lib/countries/data/**`. Changes to the YAML files will be injected during the next `rake update_cache`.

This project seeks to follow ISO3166, ISO4217 and E.164 standards in its data.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Copyright

Copyright (c) 2012-2015 hexorx \
Copyright (c) 2015-2021 hexorx, rposborne \
Copyright (c) 2022 hexorx, rposborne, pmor

See LICENSE for details.
