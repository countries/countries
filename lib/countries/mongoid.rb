module ISO3166
  class Country
    def mongoize
      ISO3166::Country.mongoize(self)
    end

    class << self
      def mongoize(country)
        if country.is_a?(self) && !country.data.nil?
          country.alpha2
        elsif send(:valid_alpha2?, country)
          new(country).alpha2
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
        country.is_a?(String) && !ISO3166::Country.new(country).nil?
      end
    end
  end
end
