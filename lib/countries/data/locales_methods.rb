# frozen_string_literal: true

module ISO3166
  module LocalesMethods
    private

    def cache_flush_required?
      return false if ISO3166.configuration.locales == @synced_locales

      flush_required = !locales_to_load.empty? || !locales_to_remove.empty?
      @synced_locales = ISO3166.configuration.locales.dup unless flush_required
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
