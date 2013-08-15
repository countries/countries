module ISO3166; end

class ISO3166::Country

  def mongoize
    ISO3166::Country.mongoize(self)
  end

  class << self

    def mongoize(country_object)
      country_object.alpha2
    end

    def demongoize(alpha2)
      ISO3166::Country.new(alpha2)
    end

    def evolve(country_object)
      mongoize(country_object)
    end
  end
end
