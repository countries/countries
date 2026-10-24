# frozen_string_literal: true

module ISO3166
  # Handles building the in memory store of countries data
  class Data
    extend SubdivisionMethods
    extend LocalesMethods

    @cache_dir = [File.dirname(__FILE__), 'cache']
    @cache = {}
    @loaded_country_codes = []
    @registered_data = {}
    @mutex = Mutex.new
    @subdivisions = {}

    def initialize(alpha2)
      alpha2 = alpha2.to_s if alpha2.is_a?(Symbol)
      alpha2 = alpha2.upcase if alpha2.match?(/[a-z]/)

      @alpha2 = alpha2
    end

    def call
      self.class.update_cache[@alpha2]
    end

    class << self
      # Registers a new Country with custom data.
      # If you are overriding an existing country, this does not perform a deep merge so you will need to __bring in all data you wish to be available__.
      # Overriding an existing country will also remove it from the internal management of translations.
      def register(data)
        alpha2 = data[:alpha2].upcase
        @registered_data[alpha2] = deep_stringify_keys(data.except('translations', :translations))
        translations = (data['translations'] || data[:translations] || {}).transform_keys(&:to_sym)
        @registered_data[alpha2]['translations'] = Translations.new.merge(translations)
        @cache = cache.merge(@registered_data)
      end

      # Removes a country from the loaded data
      def unregister(alpha2)
        alpha2 = alpha2.to_s.upcase
        @cache.delete(alpha2)
        @registered_data.delete(alpha2)
      end

      def cache
        update_cache
      end

      # Resets the loaded data and cache
      def reset
        synchronized do
          @cache = {}
          @subdivisions = {}
          @registered_data = {}
          ISO3166.configuration.loaded_locales = []
          ISO3166::Country.reset_country_cache
        end
      end

      def codes
        load_data!
        cached_codes
      end

      def update_cache
        load_data!
        sync_translations!
        @cache
      end

      def loaded_codes
        load_data!
        @loaded_country_codes
      end

      def datafile_path(file_array)
        File.join(*(@cache_dir + file_array))
      end

      private

      def load_data!
        return @cache unless load_required?

        synchronized do
          @cache = load_cache %w[countries.json]
          @loaded_country_codes = @cache.keys
          @cache = @cache.merge(@registered_data)
          @cache
        end
      end

      def sync_translations!
        return unless cache_flush_required?

        synchronized do
          removed_locales = locales_to_remove
          added_locales = locales_to_load
          next if removed_locales.empty? && added_locales.empty?

          removed_locales.each { |locale| unload_translations(locale) }
          added_locales.each { |locale| load_translations(locale) }
          refresh_translated_names

          # Publish the new locales last: lookups stop syncing as soon as they see them
          ISO3166.configuration.loaded_locales = requested_locales
        end
      end

      def synchronized(&)
        @mutex.synchronize(&)
      end

      def load_required?
        synchronized { @cache.empty? }
      end

      def cached_codes
        @cache.keys
      end

      # Codes that we have translations for in dataset
      def internal_codes
        @loaded_country_codes - @registered_data.keys
      end

      def cache_flush_required?
        !locales_to_load.empty? || !locales_to_remove.empty?
      end

      def load_translations(locale)
        locale_names = load_cache(['locales', "#{locale}.json"])
        internal_codes.each do |alpha2|
          load_alpha2_translation_for_locale(alpha2, locale, locale_names)
        end
      end

      def load_alpha2_translation_for_locale(alpha2, locale, locale_names)
        @cache[alpha2]['translations'] ||= Translations.new
        @cache[alpha2]['translations'][locale] = locale_names[alpha2].freeze
      end

      def unload_translations(locale)
        internal_codes.each do |alpha2|
          unload_alpha2_translation_for_locale(alpha2, locale)
        end
      end

      def unload_alpha2_translation_for_locale(alpha2, locale)
        @cache[alpha2]['translations'].delete(locale)
      end

      def refresh_translated_names
        internal_codes.each do |alpha2|
          @cache[alpha2]['translated_names'] = @cache[alpha2]['translations'].values.freeze
        end
      end

      def load_cache(file_array)
        file_path = datafile_path(file_array)
        File.exist?(file_path) ? JSON.parse(File.binread(file_path)) : {}
      end

      def deep_stringify_keys(data)
        data.transform_keys!(&:to_s)
        data.transform_values! { |value| value.is_a?(Hash) ? deep_stringify_keys(value) : value }

        data
      end

      def subdivision_file_path(alpha2)
        File.join(File.dirname(__FILE__), 'data', 'subdivisions', "#{alpha2}.yaml")
      end
    end
  end
end
