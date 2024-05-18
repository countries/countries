# frozen_string_literal: true

module ISO3166
  module ConversionMethods
    # @param alpha2 [String] ISO 3166 alpha-2 country code.
    # @return [String] ISO 3166 alpha-3 country code.
    def from_alpha2_to_alpha3(alpha2)
      find_country_by_alpha2(alpha2)&.alpha3
    end

    # @param alpha3 [String] ISO 3166 alpha-3 country code.
    # @return [String] ISO 3166 alpha-2 country code.
    def from_alpha3_to_alpha2(alpha3)
      find_country_by_alpha3(alpha3)&.alpha2
    end
  end
end
