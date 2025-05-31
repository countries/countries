# frozen_string_literal: true

require 'unaccent'

module ISO3166
  UNSEARCHABLE_METHODS = [:translations].freeze

  def self.Country(country_data_or_country)
    case country_data_or_country
    when ISO3166::Country
      country_data_or_country
    when String, Symbol
      ISO3166::Country.search(country_data_or_country)
    else
      raise TypeError, "can't convert #{country_data_or_country.class.name} into ISO3166::Country"
    end
  end

  module CountryClassMethods
    def new(country_data)
      return super if country_data.is_a?(Hash)

      country_code = country_data.to_s
      country_code = country_code.upcase if country_code.match?(/[a-z]/)

      super if codes.include?(country_code)
    end

    # :reek:UtilityFunction
    def codes
      ISO3166::Data.codes
    end

    def all(&block)
      block ||= proc { |_alpha2, data| ISO3166::Country.new(data) }
      ISO3166::Data.cache.map(&block)
    end

    alias countries all

    # :reek:UtilityFunction
    # :reek:ManualDispatch
    def all_names_with_codes(locale = :en)
      Country.all.map do |country|
        lc = country.translation(locale) || country.iso_short_name
        [lc.respond_to?('html_safe') ? lc.html_safe : lc, country.alpha2]
      end.sort
    end

    def pluck(*attributes)
      all.map { |country| country.data.fetch_values(*attributes.map(&:to_s)) }
    end

    def all_translated(locale = :en)
      translations(locale).values
    end

    # :reek:UtilityFunction
    # :reek:FeatureEnvy
    def translations(locale = :en)
      locale = locale.to_sym if locale.is_a?(String)
      locale = locale.downcase if locale.match?(/[A-Z]/)

      file_path = ISO3166::Data.datafile_path(%W[locales #{locale}.json])
      translations = JSON.parse(File.read(file_path))

      translations.merge(custom_countries_translations(locale))
    end

    # @param query_val [String] A value to query using `query_method`
    # @param query_method [Symbol] An optional query method, defaults to Country#alpha2
    # @param result_method [Symbol] An optional method of `Country` to apply to the result set.
    # @return [Array] An array of countries matching the provided query, or the result of applying `result_method` to the array of `Country` objects
    def collect_countries_with(query_val, query_method = :alpha2, result_method = :itself)
      return nil unless [query_method, result_method].map { |method| method_defined? method }.all?

      all.select { |country| country.send(query_method)&.include? query_val }
         .map { |country| country.send(result_method) }
    end

    # @param subdivision_str [String] A subdivision name or code to search for. Search includes translated subdivision names.
    # @param result_method [Symbol] An optional method of `Country` to apply to the result set.
    # @return [Array] An array of countries with subdivisions matching the provided name, or the result of applying `result_method` to the array of `Country` objects
    def collect_likely_countries_by_subdivision_name(subdivision_str, result_method = :itself)
      return nil unless method_defined? result_method

      all.select { |country| country.subdivision_for_string?(subdivision_str) }
         .map { |country| country.send(result_method) }
    end

    protected

    # :reek:UtilityFunction
    def strip_accents(string)
      if string.is_a?(Regexp)
        Regexp.new(Unaccent.unaccent(string.source), 'i')
      else
        Unaccent.unaccent(string.to_s).downcase
      end
    end

    # Some methods like parse_value are expensive in that they
    # create a large number of objects internally. In order to reduce the
    # object creations and save the GC, we can cache them in an class instance
    # variable. This will make subsequent parses O(1) and will stop the
    # creation of new String object instances.
    #
    # NB: We only want to use this cache for values coming from the JSON
    # file or our own code, caching user-generated data could be dangerous
    # since the cache would continually grow.
    # :reek:DuplicateMethodCall
    def cached(value)
      @_parsed_values_cache ||= {}
      return @_parsed_values_cache[value] if @_parsed_values_cache[value]

      @_parsed_values_cache[value] = yield
    end

    private

    # :reek:UtilityFunction
    def custom_countries_translations(locale)
      custom_countries = {}
      (ISO3166::Data.codes - ISO3166::Data.loaded_codes).each do |code|
        country = ISO3166::Country[code]
        translation = country.translations[locale] || country.iso_short_name
        custom_countries[code] = translation
      end

      custom_countries
    end
  end
end
