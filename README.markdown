# Countries

Countries is a collection of all sorts of useful information for every country in the ISO 3166 standard. It contains info for the following standards ISO3166-1 (countries), ISO3166-2 (states/subdivisions), ISO4217 (currency) and E.164 (phone numbers). I will add any country based data I can get access to. I hope this to be a repository for all country based information.

[![Gem Version](https://badge.fury.io/rb/countries.svg)](https://badge.fury.io/rb/countries) [![Tests](https://github.com/countries/countries/actions/workflows/tests.yml/badge.svg)](https://github.com/countries/countries/actions/workflows/tests.yml) [![Code Climate](https://codeclimate.com/github/countries/countries.svg)](https://codeclimate.com/github/countries/countries)
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

In release 4.2 the `#name` attribute was deprecated in favour of `#iso_short_name` and we added the `#iso_long_name` attribute, to make it clear that these attributes use the ISO3166 names, and are not the "common names" most people might expect, eg: The ISO name for "United Kingdom" is "United Kingdom of Great Britain and Northern Ireland", but if you're building a dropdown box to select a country, you're likely expecting to see "United Kingdom" instead.

"Common names" in English have been available in the translation data, via `#translation('en')`. As of release 4.2, a shortcut method has been added for simplicity, `#common_name`, which delegates to `#translation('en')`.

For additional clarity, the `#names` method, which was an alias to `#unofficial_names` has also been deprecated, together with the finder methods that use `name` or `names` attributes.

The `#name` and `#names` attributes, and corresponding finder methods were removed in 5.0.

The replacement finders added in 5.0 are:

- `#find_by_name` => `#find_by_any_name` - Searches all the name attributes, same as before
- `#find_by_names` => `#find_by_unofficial_names`
- `#find_*_by_name` => `#find_*_by_any_name`
- `#find_*_by_names` => `#find_*_by_unofficial_names`

With the addition of the new name attributes, there are now also the following finders:

- `#find_by_common_name`/`#find_*_by_common_name`
- `#find_by_iso_short_name`/`#find_*_by_iso_short_name`
- `#find_by_iso_long_name`/`#find_*_by_iso_long_name`

For translated country names, we use data from [pkg-isocodes](https://salsa.debian.org/iso-codes-team/iso-codes), via the [i18n_data](https://github.com/grosser/i18n_data) gem, and these generally correspond to the expected "common names". These names and the corresponding methods have not been changed.

The 5.0 release removed support for Ruby 2.5 (EOL 2021-03-01) and 2.6 (EOL 2022-03-31)

## Selective Loading of Locales

As of 2.0 you can selectively load locales to reduce memory usage in production.

By default we load `I18n.available_locales` if I18n is present, otherwise only `[:en]`. This means almost any Rails environment will only bring in its supported translations.

You can add all the locales like this.

```ruby
ISO3166.configure do |config|
  config.locales = [:af, :am, :ar, :as, :az, :be, :bg, :bn, :br, :bs, :ca, :cs, :cy, :da, :de, :dz, :el, :en, :eo, :es, :et, :eu, :fa, :fi, :fo, :fr, :ga, :gl, :gu, :he, :hi, :hr, :hu, :hy, :ia, :id, :is, :it, :ja, :ka, :kk, :km, :kn, :ko, :ku, :lt, :lv, :mi, :mk, :ml, :mn, :mr, :ms, :mt, :nb, :ne, :nl, :nn, :oc, :or, :pa, :pl, :ps, :pt, :ro, :ru, :rw, :si, :sk, :sl, :so, :sq, :sr, :sv, :sw, :ta, :te, :th, :ti, :tk, :tl, :tr, :tt, :ug, :uk, :ve, :vi, :wa, :wo, :xh, :zh, :zu]
end
```

or something a bit more simple
```ruby
ISO3166.configure do |config|
  config.locales = [:en, :de, :fr, :es]
end
```

## Attribute-Based Finder Methods

You can lookup a country or an array of countries using any of the data attributes via the find\_country\_by_*attribute* dynamic methods:

```ruby
c    = ISO3166::Country.find_country_by_iso_short_name('italy')
c    = ISO3166::Country.find_country_by_any_name('united states')
h    = ISO3166::Country.find_all_by(:translated_names, 'França')
list = ISO3166::Country.find_all_countries_by_region('Americas')
c    = ISO3166::Country.find_country_by_alpha3('can')
```

For a list of available attributes please see `ISO3166::DEFAULT_COUNTRY_HASH`.
Note: searches are *case insensitive and ignore accents*.

_Please note that `find_by_name`, `find_by_names`, `find_*_by_name` and `find_*_by_names`  methods were removed in 5.0. See [Upgrading to 4.2 and 5.x](#upgrading-to-4-2-and-5-x) above for the new methods_

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
c.common_name # => "United States" (This is a shortcut for c.translations('en'))
c.unofficial_names # => ["United States of America", "Vereinigte Staaten von Amerika", "États-Unis", "Estados Unidos"]

# Get the names for a country translated to its local languages
c = Country[:BE]
c.local_names # => ["België", "Belgique", "Belgien"]
c.local_name # => "België"

# Get a specific translation
c.translation('de') # => 'Vereinigte Staaten von Amerika'
c.translations['fr'] # => "États-Unis"

ISO3166::Country.translations         # {"DE"=>"Germany",...}
ISO3166::Country.translations('DE')   # {"DE"=>"Deutschland",...}
ISO3166::Country.all_translated       # ['Germany', ...]
ISO3166::Country.all_translated('DE') # ['Deutschland', ...]

# Nationality
c.nationality # => "American"
```

### Subdivisions & States

```ruby
c.subdivisions # => {"CO" => {"name" => "Colorado", "names" => "Colorado"}, ... }
c.states # => {"CO" => {"name" => "Colorado", "names" => "Colorado"}, ... }
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

### Plucking multiple attributes

```ruby
ISO3166::Country.pluck(:alpha2, :iso_short_name) # => [["AD", "Andorra"], ["AE", "United Arab Emirates"], ...
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

## Loading Custom Data

As of 2.0 countries supports loading custom countries / overriding data in its data set, though if you choose to do this please contribute back to the upstream repo!

Any country registered this way will have its data available for searching etc... If you are overriding an existing country, for cultural reasons, our code uses a simple merge, not a deep merge so you will need to __bring in all data you wish to be available__.  Bringing in an existing country will also remove it from the internal management of translations, __all registered countries will remain in memory__.

```ruby
ISO3166::Data.register(
  alpha2: 'LOL',
  iso_short_name: 'Happy Country',
  translations: {
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

## Country Code in Emoji

```ruby
c = Country['MY']
c.emoji_flag # => "🇲🇾"
```

## Note on Patches/Pull Requests

### Please do not submit pull requests on `cache/**/*`

Any additions should be directed upstream to [pkg-isocodes](https://salsa.debian.org/iso-codes-team/iso-codes)

Localized country name data is sourced from https://github.com/grosser/i18n_data (which is based on https://salsa.debian.org/iso-codes-team/iso-codes/). Issues regarding localized country names can be reported to https://github.com/grosser/i18n_data/issues or https://salsa.debian.org/iso-codes-team/iso-codes/issues
If you need to correct an upstream translation please add it to the lib/countries/data/translations_corrections.yaml

```
# Ex:
#
# locale:
#   alpha2: localized_name
#
```

Any corrections can be applied in translations_corrections.yaml these will be injected during
the next `rake update_cache`.

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but
   bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2012-2015 hexorx
Copyright (c) 2015-2021 hexorx, rposborne
Copyright (c) 2022 hexorx, rposborne, pmor

See LICENSE for details.
