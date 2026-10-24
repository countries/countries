# frozen_string_literal: true

module ISO3166
  module LocalesMethods
    private

    def cache_flush_required?
      configuration = ISO3166.configuration
      return false if configuration.equal?(@synced_configuration) && configuration.locales == @synced_locales

      # Copied before the diff: locales assigned meanwhile by another thread must not be marked as synced
      candidate_locales = configuration.locales.dup
      flush_required = !locales_to_load.empty? || !locales_to_remove.empty?
      unless flush_required
        @synced_locales = candidate_locales
        @synced_configuration = configuration
      end
      flush_required
    end

    def locales_to_load
      requested_locales - loaded_locales
    end

    def locales_to_remove
      loaded_locales - requested_locales
    end

    # :reek:UtilityFunction
    def requested_locales
      ISO3166.configuration.locales.map { |locale| locale.match?(/[A-Z]/) ? locale.downcase : locale }
    end

    # :reek:UtilityFunction
    def loaded_locales
      ISO3166.configuration.loaded_locales.map { |locale| locale.match?(/[A-Z]/) ? locale.downcase : locale }
    end
  end
end
