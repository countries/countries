# frozen_string_literal: true

module ISO3166
  module LocalesMethods
    private

    def locales_to_load
      requested_locales - loaded_locales
    end

    def locales_to_remove
      loaded_locales - requested_locales
    end

    # @return [Array(Array<Symbol>, Array<Symbol>)] the locales to unload and to load to reach +requested+
    def locale_changes(requested)
      loaded = loaded_locales
      [loaded - requested, requested - loaded]
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
