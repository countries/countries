module ISO3166
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
    Data.reset
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :locales, :loaded_locales

    def initialize
      @locales = default_locales
      @loaded_locales = []
    end

    def enable_currency_extension!
      require 'countries/country/currency_methods'
      ISO3166::Country.prepend(ISO3166::CountryCurrencyMethods)
    end

    private

    def default_locales
      locales = if Object.const_defined?('I18n') && I18n.respond_to?(:available_locales)
                  I18n.available_locales
                else
                  [:en]
                end

      locales.empty? ? [:en] : locales
    end
  end
end
