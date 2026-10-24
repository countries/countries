# frozen_string_literal: true

module ISO3166
  module LocalesMethods
    private

    def cache_flush_required?
      configuration = ISO3166.configuration
      synced_configuration, synced_locales = @synced_snapshot
      return false if configuration.equal?(synced_configuration) && configuration.locales == synced_locales

      # Under the lock so loaded_locales cannot change between the diff and the snapshot of that same copy
      synchronized do
        locales = configuration.locales.dup
        flush_required = !locales_synced?(locales)
        @synced_snapshot = flush_required ? nil : [configuration, locales].freeze
        flush_required
      end
    end

    def locales_synced?(locales)
      requested = requested_locales(locales)
      loaded = loaded_locales
      (requested - loaded).empty? && (loaded - requested).empty?
    end

    def locales_to_load
      requested_locales - loaded_locales
    end

    def locales_to_remove
      loaded_locales - requested_locales
    end

    # :reek:UtilityFunction
    def requested_locales(locales = ISO3166.configuration.locales)
      locales.map { |locale| locale.match?(/[A-Z]/) ? locale.downcase : locale }
    end

    # :reek:UtilityFunction
    def loaded_locales
      ISO3166.configuration.loaded_locales.map { |locale| locale.match?(/[A-Z]/) ? locale.downcase : locale }
    end
  end
end
