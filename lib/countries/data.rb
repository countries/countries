module ISO3166
  ##
  # Handles building the in memory store of countries data
  class Data
    @@cache = {}
    @@registered_data = {}

    def initialize(alpha2)
      @alpha2 = alpha2.to_s.upcase
      self.class.update_cache
    end

    def call
      @@cache[@alpha2]
    end

    class << self

      def register(data)
        alpha2 = data[:alpha2].upcase
        @@registered_data[alpha2] = \
         data.inject({}) { |a,(k,v)| a[k.to_s] = v;  a }
        @@cache = cache.merge(@@registered_data)
      end

      def unregister(alpha2)
        alpha2 = alpha2.to_s.upcase
        @@cache.delete(alpha2)
        @@registered_data.delete(alpha2)
      end

      def cache
        update_cache
      end

      def reset
        @@cache = {}
        @@registered_data = {}
        ISO3166.configuration.loaded_locales = []
      end

      def codes
        load_data!
        loaded_codes
      end

      def update_cache
        load_data!
        sync_translations!
        @@cache
      end

      private

      def load_data!
        return @@cache unless @@cache.size == loaded_codes || @@cache.keys.empty?
        @@cache = load_cache %w(cache countries.json )
        @@cache = @@cache.merge(@@registered_data)
        @@cache
      end

      def sync_translations!
        return unless cache_flush_required?

        locales_to_remove.each do |locale|
          unload_translations(locale)
        end

        locales_to_load.each do |locale|
          load_translations(locale)
        end
      end

      private

      def loaded_codes
        (@@cache.keys + @@registered_data.keys).uniq
      end

      # Codes that we have translations for in dataset
      def internal_codes
        loaded_codes - @@registered_data.keys
      end

      def cache_flush_required?
        locales_to_load.size != 0 || locales_to_remove.size != 0
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
        locale_names = load_cache(['cache', 'locales', "#{locale}.json"])
        internal_codes.each do |alpha2|
          @@cache[alpha2]['translations'] ||= {}
          @@cache[alpha2]['translations'][locale] = locale_names[alpha2].freeze
          @@cache[alpha2]['translated_names'] = @@cache[alpha2]['translations'].values.freeze
        end
        ISO3166.configuration.loaded_locales << locale
      end

      def unload_translations(locale)
        internal_codes.each do |alpha2|
          @@cache[alpha2]['translations'].delete(locale)
          @@cache[alpha2]['translated_names'] = @@cache[alpha2]['translations'].values.freeze
        end
        ISO3166.configuration.loaded_locales.delete(locale)
      end

      def load_cache(file_array)
        file_path = datafile_path(file_array)
        File.exist?(file_path) ? JSON.load(File.binread(file_path)) : {}
      end

      def datafile_path(file_array)
        File.join([File.dirname(__FILE__)] + file_array)
      end
    end
  end
end
