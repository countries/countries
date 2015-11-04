module ISO3166
  ##
  # Handles building the in memory store of countries data
  class Data
    @@cache = nil
    def initialize(alpha2)
      @alpha2 = alpha2.to_s.upcase
      Data.load_cache unless @@cache
    end

    def call
      @@cache[@alpha2]
    end

    def self.codes
      @@codes ||= Data.load_yaml(['countries', 'data', 'countries.yaml']).freeze
    end

    private

    def self.datafile_path(file_array)
      File.join([File.dirname(__FILE__), '..'] + file_array)
    end

    def self.load_yaml(file_array)
      YAML.load_file(datafile_path(file_array))
    end

    def self.load_cache
      @@cache ||= Marshal.load(File.binread(datafile_path %w(countries cache countries )))
    end
  end
end
