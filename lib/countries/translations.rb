module ISO3166
  class Translations < Hash
    def [](locale)
      super(locale) || super(locale.sub(/-.*/, ""))
    end
  end
end
