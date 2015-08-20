module ISO3166
  ##
  # Handles building the in memory store of countries data
  class Data
    def initialize(alpha2)
      @alpha2 = alpha2.to_s.upcase
    end

    def call
      CACHE[@alpha2]
    end

    def self.codes
      @@codes ||= Data.load_yaml(['data', 'countries.yaml']).freeze
    end

    private

    def self.datafile_path(file_array)
      File.join([File.dirname(__FILE__), '..'] + file_array)
    end

    def self.load_yaml(file_array)
      YAML.load_file(datafile_path(file_array))
    end

    CACHE = Marshal.load(File.binread(Data.datafile_path(%w(cache countries))))
  end
end
