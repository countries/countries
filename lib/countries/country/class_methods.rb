module ISO3166
  def ISO3166::Country(country_data_or_country)
    case country_data_or_country
    when ISO3166::Country
      country_data_or_country
    when String, Symbol
      ISO3166::Country.search(country_data_or_country)
    else
      fail TypeError, "can't convert #{country_data_or_country.class.name} into ISO3166::Country"
    end
  end

  class Country
    class << self
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

      alias_method :countries, :all

      def all_translated(locale = 'en')
        translations(locale).values
      end

      def all_names_with_codes(locale = 'en')
        ISO3166::Country.all.map do |c|
          [(c.translation(locale) || c.name).html_safe, c.alpha2]
        end.sort_by { |d| d[0] }
      end

      def translations(locale = 'en')
        I18nData.countries(locale.upcase)
      end

      def search(query)
        country = new(query.to_s.upcase)
        (country && country.valid?) ? country : nil
      end

      def [](query)
        search(query)
      end

      def method_missing(*m)
        regex = m.first.to_s.match(/^find_(all_)?(country_|countries_)?by_(.+)/)
        super unless regex

        countries = find_by(Regexp.last_match[3], m[1], Regexp.last_match[2])
        Regexp.last_match[1] ? countries : countries.last
      end

      def find_all_by(attribute, val)
        attributes, value = parse_attributes(attribute, val)

        ISO3166::Data.cache.select do |_, v|
          attributes.map do |attr|
            Array(Country.new(v).send(attr)).any? { |n| value === sterlize_value(n)}
          end.include?(true)
        end
      end

      def sterlize_value(v)
        if v.is_a?(Regexp)
          Regexp.new(v.source.unaccent, 'i')
        else
          UnicodeUtils.downcase(v.to_s.unaccent)
        end
      end

      protected

      def parse_attributes(attribute, val)
        fail "Invalid attribute name '#{attribute}'" unless instance_methods.include?(attribute.to_sym)

        attributes = Array(attribute.to_s)
        if attributes == ['name']
          attributes << 'unofficial_names'
          # TODO: Revisit when better data from i18n_data
          # attributes << 'translated_names'
        end

        [attributes, sterlize_value(val)]
      end

      def find_by(attribute, value, obj = nil)
        find_all_by(attribute.downcase, value).map do |country|
          obj.nil? ? country : new(country.last)
        end
      end
    end
  end
end
