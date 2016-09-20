module ISO3166
  # Extend the hash class to allow locale lookup fall back behavior
  #
  # ex:
  # if a country has translations for pt, and the user looks up `pt-br` fallback
  # to `pt` to prevent from showing nil values
  class Translations < Hash
    def [](locale)
      super(locale) || super(locale.sub(/-.*/, ''))
    end
  end
end
