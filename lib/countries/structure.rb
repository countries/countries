# frozen_string_literal: true
#
module ISO3166
  module Countries
    DEFAULT_COUNTRY_HASH = {
      "address_format" => "",
      "alpha2" => "",
      "alpha3" => "",
      "continent" => "",
      "country_code" => "",
      "currency" => "",
      "gec" => "",
      "geo" => {
        "latitude" => "",
        "latitude_dec" => "",
        "longitude" => "",
        "longitude_dec" => "",
        "max_latitude" => "",
        "max_longitude" => "",
        "min_latitude" => "",
        "min_longitude" => "",
      },
      "international_prefix" => "",
      "ioc" => "",
      "name" => "",
      "national_destination_code_lengths" => [],
      "national_number_lengths" => [],
      "national_prefix" => "",
      "nationality" => "",
      "number" => "",
      "languages_official" => [
        ""
      ],
      "languages_spoken" => [
        ""
      ],
      "translated_names" => [],
      "translations" => {},
      "postal_code" => nil,
      "region" => "",
      "unofficial_names" => [],
      "subregion" => "",
      "un_locode" => "",
      "vat_rates" => {
        "standard" => nil,
        "reduced" => [ nil, nil ],
        "super_reduced" => nil,
        "parking" => nil
      },
      "world_region" => ""
    }
  end
end
