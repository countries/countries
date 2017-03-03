module ISO3166
  class Country
    extend CountryClassMethods
    include Emoji
    attr_reader :data

    ISO3166::DEFAULT_COUNTRY_HASH.each do |method_name, _type|
      define_method method_name do
        data[method_name.to_s]
      end
    end

    ISO3166::DEFAULT_COUNTRY_HASH['geo'].each do |method_name, _type|
      define_method method_name do
        data['geo'][method_name.to_s]
      end
    end

    def initialize(country_data)
      @country_data_or_code = country_data
      reload
    end

    def valid?
      !(data.nil? || data.empty?)
    end

    alias zip postal_code
    alias zip? postal_code
    alias postal_code? postal_code
    alias languages languages_official
    alias names unofficial_names

    def ==(other)
      other.respond_to?(:alpha2) && other.alpha2 == alpha2
    end

    def eql?(other)
      self == other
    end

    def hash
      [alpha2, alpha3].hash
    end

    def <=>(other)
      to_s <=> other.to_s
    end

    def currency
      Money::Currency.find(data['currency_code'])
    end

    def start_of_week
      data['start_of_week']
    end

    def subdivisions?
      File.exist?(subdivision_file_path)
    end

    def subdivisions
      @subdivisions ||= subdivision_data.inject({}) do |hash, (k, v)|
        hash.merge(k => Subdivision.new(v))
      end
    end

    alias states subdivisions

    def in_eu?
      data['eu_member'].nil? ? false : data['eu_member']
    end

    def in_eea?
      data['eea_member'].nil? ? false : data['eea_member']
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

    # TODO: Looping through locale langs could be be very slow across multiple countries
    def local_names
      ISO3166.configuration.locales = (ISO3166.configuration.locales + languages.map(&:to_sym)).uniq
      reload

      @local_names ||= languages.map { |language| translations[language] }
    end

    def local_name
      @local_name ||= local_names.first
    end

    def reload
      @data = if @country_data_or_code.is_a?(Hash)
                @country_data_or_code
              else
                ISO3166::Data.new(@country_data_or_code).call
              end
    end

    private

    def subdivision_data
      @subdivision_data ||= if subdivisions?
                              YAML.load_file(subdivision_file_path)
                            else
                              {}
                            end
    end

    def subdivision_file_path
      File.join(File.dirname(__FILE__), 'data', 'subdivisions', "#{alpha2}.yaml")
    end
  end
end
