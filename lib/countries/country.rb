module ISO3166
  class Country
    attr_reader :data

    ISO3166::Countries::DEFAULT_COUNTRY_HASH.each do |method_name, type|
      define_method method_name do
        data[method_name.to_s]
      end
    end

    ISO3166::Countries::DEFAULT_COUNTRY_HASH["geo"].each do |method_name, type|
      define_method method_name do
        data["geo"][method_name.to_s]
      end
    end

    def initialize(country_data)
      @data = country_data.is_a?(Hash) ? country_data : ISO3166::Data.new(country_data).call
    end

    def valid?
      !(data.nil? || data.empty?)
    end

    alias_method :zip, :postal_code
    alias_method :zip?, :postal_code
    alias_method :postal_code?, :postal_code
    alias_method :languages, :languages_official
    alias_method :names, :unofficial_names

    def ==(other)
      other == data
    end

    def <=>(other)
      to_s <=> other.to_s
    end

    def currency
      Money::Currency.find(data['currency_code'])
    end

    def subdivisions
      @subdivisions ||= subdivisions? ? YAML.load_file(File.join(File.dirname(__FILE__), 'data', 'subdivisions', "#{alpha2}.yaml")) : {}
    end

    alias_method :states, :subdivisions

    def subdivisions?
      File.exist?(File.join(File.dirname(__FILE__), 'data', 'subdivisions', "#{alpha2}.yaml"))
    end

    def in_eu?
      data['eu_member'].nil? ? false : data['eu_member']
    end

    def to_s
      data['name']
    end

    def translated_names
      data['translations'].values
    end

    def translation(locale = 'en')
      data['translations'][locale.to_s.downcase]
    end

    def local_names
      @local_names ||= languages.map { |language| translations[language] }
    end

    def local_name
      @local_name ||= local_names.first
    end

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
            Array(Country.new(v).send(attr)).any? { |n| value === UnicodeUtils.downcase(n.to_s.unaccent)}
          end.include?(true)
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

        val = (val.is_a?(Regexp) ? Regexp.new(val.source.unaccent, 'i') : UnicodeUtils.downcase(val.to_s.unaccent))

        [attributes, val]
      end

      def find_by(attribute, value, obj = nil)
        find_all_by(attribute.downcase, value).map do |country|
          obj.nil? ? country : new(country.last)
        end
      end
    end
  end

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
end
