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

    private

    def default_locales
      if Object.const_defined?('I18n') && I18n.respond_to?(:available_locales)
        I18n.available_locales
      else
        [:en]
      end
    end
  end
end
