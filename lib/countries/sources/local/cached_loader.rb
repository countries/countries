module Sources
  module Local
    class CachedLoader
      attr_reader :klass
      def initialize(klass)
        @klass = klass
        @loaded_countries = {}
      end

      def from_cache(country_code)
        @loaded_countries[country_code]
      end

      def load(country_code)
        if (data = from_cache(country_code))
          data
        else
          @loaded_countries[country_code] = klass.load(country_code)
        end
      end

      def save(country_code, data)
        klass.new(country_code).save(data)
      end
    end
  end
end
