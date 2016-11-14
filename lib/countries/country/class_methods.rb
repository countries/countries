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
      Country.all.map { |c| [(c.translation(locale) || c.name).html_safe, c.alpha2] }.sort
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
        matches[3].all? { |a| instance_methods.include?(a.to_sym) }
      else
        super
      end
    end

    def find_all_by(attribute, val)
      attributes, lookup_value = parse_attributes(attribute, val)

      ISO3166::Data.cache.select do |_, v|
        country = Country.new(v)
        attributes.any? do |attr|
          Array(country.send(attr)).any? { |n| lookup_value === strip_accents(n) }
        end
      end
    end

    def strip_accents(v)
      if v.is_a?(Regexp)
        Regexp.new(v.source.unaccent, 'i')
      else
        UnicodeUtils.downcase(v.to_s.unaccent)
      end
    end

    protected

    def parse_attributes(attribute, val)
      raise "Invalid attribute name '#{attribute}'" unless searchable_attribute?(attribute.to_sym)

      attributes = Array(attribute.to_s)
      if attributes == ['name']
        attributes << 'unofficial_names'
        # TODO: Revisit when better data from i18n_data
        # attributes << 'translated_names'
      end

      [attributes, strip_accents(val)]
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
  end
end
