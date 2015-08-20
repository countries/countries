module ISO3166
  ##
  # Handles building the in memory store of countries data
  class Data
    def initialize(alpha2)
      @alpha2 = alpha2.to_s.upcase
    end

    def call
      cache(@alpha2)
    end

    def self.codes
      @@codes ||= Data.load_yaml(['data', 'countries.yaml']).freeze
    end

    private

    def cache(alpha2)
      @@data ||= Data.load_marshal(['cache', "countries"])
      @@data[alpha2]
    end

    def self.datafile_path(file_array)
      File.join([File.dirname(__FILE__), '..'] + file_array)
    end

    def self.load_yaml(file_array)
      YAML.load_file(datafile_path(file_array))
    end

    def self.load_marshal(file_array)
       Marshal.load(File.binread(datafile_path(file_array)))
    end
  end
end
