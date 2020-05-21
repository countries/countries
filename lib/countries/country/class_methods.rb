require 'unicode_utils/downcase'
require 'sixarm_ruby_unaccent'

module ISO3166
  UNSEARCHABLE_METHODS = [:translations].freeze

  def self::Country(country_data_or_country)
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
    FIND_BY_REGEX = /^find_(all_)?(country_|countries_)?by_(.+)/
    SEARCH_TERM_FILTER_REGEX = /\(|\)|\[\]|,/

    def new(country_data)
      super if country_data.is_a?(Hash) || codes.include?(country_data.to_s.upcase)
    end

    def codes
      ISO3166::Data.codes
    end

    def all(&blk)
      blk ||= proc { |_alpha2, d| ISO3166::Country.new(d) }
      ISO3166::Data.cache.map(&blk)
    end

    alias countries all

    def all_translated(locale = 'en')
      translations(locale).values
    end

    def all_names_with_codes(locale = 'en')
      Country.all.map do |c|
        lc = (c.translation(locale) || c.name)
        [lc.respond_to?('html_safe') ? lc.html_safe : lc, c.alpha2]
      end.sort
    end

    def translations(locale = 'en')
      I18nData.countries(locale.upcase)
    end

    def search(query)
      country = new(query.to_s.upcase)
      country && country.valid? ? country : nil
    end

    def [](query)
      search(query)
    end

    def method_missing(method_name, *arguments)
      matches = method_name.to_s.match(FIND_BY_REGEX)
      return_all = matches[1]
      super unless matches

      countries = find_by(matches[3], arguments[0], matches[2])
      return_all ? countries : countries.last
    end

    def respond_to_missing?(method_name, include_private = false)
      matches = method_name.to_s.match(FIND_BY_REGEX)
      if matches && matches[3]
        instance_methods.include?(matches[3].to_sym)
      else
        super
      end
    end

    def find_all_by(attribute, val)
      attributes, lookup_value = parse_attributes(attribute, val)

      ISO3166::Data.cache.select do |_, v|
        country = Country.new(v)
        attributes.any? do |attr|
          Array(country.send(attr)).any? do |n|
            lookup_value === cached(n) { parse_value(n) }
          end
        end
      end
    end

    def subdivisions(alpha2)
      @subdivisions ||= {}
      @subdivisions[alpha2] ||= create_subdivisions(subdivision_data(alpha2))
    end

    def create_subdivisions(subdivision_data)
      subdivision_data.each_with_object({}) do |(k, v), hash|
        hash[k] = Subdivision.new(v)
      end
    end

    protected

    def strip_accents(v)
      if v.is_a?(Regexp)
        Regexp.new(v.source.unaccent, 'i')
      else
        UnicodeUtils.downcase(v.to_s.unaccent)
      end
    end

    def parse_attributes(attribute, val)
      raise "Invalid attribute name '#{attribute}'" unless searchable_attribute?(attribute.to_sym)

      attributes = Array(attribute.to_s)
      if attributes == ['name']
        attributes << 'unofficial_names'
        # TODO: Revisit when better data from i18n_data
        # attributes << 'translated_names'
      end

      [attributes, parse_value(val)]
    end

    def searchable_attribute?(attribute)
      searchable_attributes.include?(attribute.to_sym)
    end

    def searchable_attributes
      instance_methods - UNSEARCHABLE_METHODS
    end

    def find_by(attribute, value, obj = nil)
      find_all_by(attribute.downcase, value).map do |country|
        obj.nil? ? country : new(country.last)
      end
    end

    def parse_value(value)
      value = value.gsub(SEARCH_TERM_FILTER_REGEX, '') if value.respond_to?(:gsub)
      strip_accents(value)
    end

    def subdivision_data(alpha2)
      file = subdivision_file_path(alpha2)
      File.exist?(file) ? YAML.load_file(file) : {}
    end

    def subdivision_file_path(alpha2)
      File.join(File.dirname(__FILE__), '..', 'data', 'subdivisions', "#{alpha2}.yaml")
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
    def cached(value)
      @_parsed_values_cache ||= {}
      return @_parsed_values_cache[value] if @_parsed_values_cache[value]
      @_parsed_values_cache[value] = yield
    end
  end
end
