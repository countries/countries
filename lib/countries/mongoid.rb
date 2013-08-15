module ISO3166; end

class ISO3166::Country
  class BadMongoidTypeError < StandardError; end

  def mongoize
    ISO3166::Country.mongoize(self)
  end

  class << self

    def mongoize(country)
      if country.is_a?(self) && !country.data.nil?
        country.alpha2
      elsif self.send(:valid_alpha2?, country)
        new(country).alpha2
      else
        raise BadMongoidTypeError.new('Given value is neither a valid country object nor a valid alpha2 code')
      end
    end

    def demongoize(alpha2)
      new(alpha2)
    end

    def evolve(country)
      mongoize(country)
    end

    private

    def valid_alpha2?(country)
      return false unless country.is_a?(String)

      if ISO3166::Country.new(country).nil?
        raise BadMongoidTypeError.new('Given string is not a valid alpha2 code.')
      else
        true
      end
    end
  end
end
