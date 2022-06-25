# Upgrading to 4.2 and 5.x

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

For translated country names, we use data originally sourced from [pkg-isocodes](https://salsa.debian.org/iso-codes-team/iso-codes), via the [i18n_data](https://github.com/grosser/i18n_data) gem, and these generally correspond to the expected "common names". Some corrections have been applied to these localized names. The methods to access translated names have not been changed.

The 5.0 release removed support for Ruby 2.5 (EOL 2021-03-01) and 2.6 (EOL 2022-03-31)

# Upgrading to 5.1

In release 5.1 a `type` attribute was added to the subdivisions object, to allow filtering the collection of subdivisions.

- `Country#subdivision_types` returns a list of subdivision types for that country (lowercase, snake_cased)
- `#subdivisions_of_types(types)` accepts an array of subdivision types and returns the subdivisions for those types

The `#states` method is deprecated to avoid confusion, as this method is an alias to `#subdivisions` and returns all subdivisions, regardless of type.

To get a list of `state` subdivisions (something that was not possible before 5.1), use `subdivisions_of_types(['state'])`

Please note that the subdivision types are obtained from ISO data, and each country defines its own subdivision types, eg: `state`, `district`, `region`, `municipality` and many others types exist.
