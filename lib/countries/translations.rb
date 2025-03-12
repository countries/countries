# frozen_string_literal: true

module ISO3166
  # Extend the hash class to allow locale lookup fall back behavior
  #
  # E.g. if a country has translations for +pt+, and the user looks up +pt-br+ fallback
  # to +pt+ to prevent from showing nil values
  #
  # Also allows "indifferent access" to the hash, so you can use strings or symbols
  class Translations < Hash
    def [](locale)
      translations = locale.is_a?(String) ? super(locale.to_sym) : super
      return translations if translations

      super(locale.to_s.sub(/-.*/, '').to_sym)
    end
  end
end
