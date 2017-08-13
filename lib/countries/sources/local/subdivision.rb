module Sources
  module Local
    class Subdivision
      attr_reader :code
      def initialize(code)
        @code = code
      end

      def load
        if File.exist?(file_path)
          YAML.load_file(file_path) || {}
        else
          {}
        end
      end

      def save(data)
        File.open(file_path, 'w') { |f| f.write data.to_yaml }
      rescue
        puts "failed to read #{file}: #{$ERROR_INFO}"
      end

      def file_path
        "lib/countries/data/subdivisions/#{code}.yaml"
      end

      def self.load(code)
        new(code).load
      end
    end
  end
end
