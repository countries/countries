module ISO3166
  class << self
    attr_accessor :configuration
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
      @locales = [:en]
      @loaded_locales = []
    end
  end
end
