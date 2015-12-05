module ISO3166
  ##
  # Handles building the in memory store of countries data
  class Data
    @@cache = nil
    def initialize(alpha2)
      self.class.update_cache
      @alpha2 = alpha2.to_s.upcase
    end

    def call
      @@cache[@alpha2]
    end

    class << self
      def cache
        update_cache
      end

      def reset
        @@cache = nil
        @@codes = nil
      end

      def codes
        @@codes ||= load_yaml(['data', 'countries.yaml']).freeze
      end

      def update_cache
        return @@cache unless cache_flush_required?
        @@cache ||= marshal %w(cache countries )

        locales_to_remove.each do |locale|
          unload_translations(locale)
        end

        locales_to_load.each do |locale|
          load_translations(locale)
        end

        @@cache.freeze
      end
     private
      def cache_flush_required?
        locales_to_load.size && locales_to_remove.size
      end

      def locales_to_load
        requested_locales - loaded_locales
      end

      def locales_to_remove
        loaded_locales - requested_locales
      end

      def requested_locales
        ISO3166.configuration.locales.map { |l| l.to_s.downcase }
      end

      def loaded_locales
        ISO3166.configuration.loaded_locales.map { |l| l.to_s.downcase }
      end

      def load_translations(locale)
        locale_names = marshal(['cache', 'locales', locale])
        codes.each do |alpha2|
          @@cache[alpha2]['translations'] ||= {}
          @@cache[alpha2]['translations'][locale] = locale_names[alpha2].freeze
          @@cache[alpha2]['translated_names'] = @@cache[alpha2]['translations'].values.freeze
        end
        ISO3166.configuration.loaded_locales << locale
      end

      def unload_translations(locale)
        codes.each do |alpha2|
          @@cache[alpha2]['translations'].delete(locale)
          @@cache[alpha2]['translated_names'] = @@cache[alpha2]['translations'].values.freeze
        end
        ISO3166.configuration.loaded_locales.delete(locale)
      end

      def marshal(file_array)
        Marshal.load(File.binread(datafile_path file_array))
      end

      def datafile_path(file_array)
        File.join([File.dirname(__FILE__)] + file_array)
      end

      def load_yaml(file_array)
        YAML.load_file(datafile_path(file_array))
      end
    end
  end
end
