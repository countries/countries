module ISO3166; end

class ISO3166::Country
  Codes = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'data', 'countries.yaml'))
  Translations = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'cache', 'translations.yaml'))
  Data = {}
  Codes.each do |alpha2|
    Data[alpha2] = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'data', 'countries', "#{alpha2}.yaml"))[alpha2]
    Data[alpha2] = Data[alpha2].merge(Translations[alpha2])
  end
  Names = I18nData.countries.values.sort_by { |d| d[0] }

  AttrReaders = [
    :number,
    :alpha2,
    :alpha3,
    :name,
    :names,
    :latitude,
    :longitude,
    :continent,
    :region,
    :subregion,
    :world_region,
    :country_code,
    :national_destination_code_lengths,
    :national_number_lengths,
    :international_prefix,
    :national_prefix,
    :address_format,
    :translations,
    :translated_names,
    :ioc,
    :gec,
    :un_locode,
    :languages,
    :nationality,
    :dissolved_on,
    :eu_member,
    :alt_currency,
    :vat_rates,
    :postal_code,
    :min_longitude,
    :min_latitude,
    :max_longitude,
    :max_latitude,
    :latitude_dec,
    :longitude_dec
  ]

  AttrReaders.each do |meth|
    define_method meth do
      @data[meth.to_s]
    end
  end

  attr_reader :data

  def initialize(country_data)
    @data = country_data.is_a?(Hash) ? country_data : Data[country_data.to_s.upcase]
  end

  def valid?
    !(@data.nil? || @data.empty?)
  end

  alias_method :zip, :postal_code
  alias_method :zip?, :postal_code
  alias_method :postal_code?, :postal_code

  def ==(other)
    other == data
  end

  def currency
    ISO4217::Currency.from_code(@data['currency'])
  end

  def currency_code
    @data['currency']
  end

  def subdivisions
    @subdivisions ||= subdivisions? ? YAML.load_file(File.join(File.dirname(__FILE__), '..', 'data', 'subdivisions', "#{alpha2}.yaml")) : {}
  end

  alias_method :states, :subdivisions

  def subdivisions?
    File.exist?(File.join(File.dirname(__FILE__), '..', 'data', 'subdivisions', "#{alpha2}.yaml"))
  end

  def in_eu?
    @data['eu_member'].nil? ? false : @data['eu_member']
  end

  def to_s
    @data['name']
  end

  def translation(locale = 'en')
    @data['translations'][locale.downcase]
  end

  private

  class << self
    def new(country_data)
      if country_data.is_a?(Hash) || Data.keys.include?(country_data.to_s.upcase)
        super
      end
    end

    def all(&blk)
      blk ||= proc { |country, data| [data['name'], country] }
      Data.map(&blk)
    end

    alias_method :countries, :all

    def all_translated(locale = 'en')
      translations(locale).values
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

      Data.select do |_, v|
        attributes.map do |attr|
          Array(v[attr]).any? { |n| value === n.to_s.downcase }
        end.include?(true)
      end
    end

    protected

    def parse_attributes(attribute, val)
      fail "Invalid attribute name '#{attribute}'" unless instance_methods.include?(attribute.to_sym)

      attributes = Array(attribute.to_s)
      if attributes == ['name']
        attributes << 'names'
        # TODO: Revisit when better data from i18n_data
        # attributes << 'translated_names'
      end

      val = (val.is_a?(Regexp) ? Regexp.new(val.source, 'i') : val.to_s.downcase)

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
