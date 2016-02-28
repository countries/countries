# frozen_string_literal: true
#
module ISO3166
  module Countries
    module Structure
      Structure = {
        address_format: "",
        alpha2: "",
        alpha3: "",
        continent: "",
        country_code: "",
        currency: "",
        gec: "",
        geo: {
          latitude: "",
          latitude_dec: "",
          longitude: "",
          longitude_dec: "",
          max_latitude: "",
          max_longitude: "",
          min_latitude: "",
          min_longitude: "",
        },
        international_prefix: "",
        ioc: "",
        name: "",
        national_destination_code_lengths: [],
        national_number_lengths: [],
        national_prefix: "",
        nationality: "",
        number: "",
        languages_offical: [
          ""
        ],
        languages_spoken: [
          ""
        ],
        translated_names: [],
        translations: {},
        postal_code: true,
        region: "",
        slang_names: [],
        subregion: "",
        un_locode: "",
        vat_rates: "",
        world_region: ""
      }

      Structure.each do |method_name, type|
        define_method method_name do
          @data[method_name.to_s]
        end
      end

      Structure[:geo].each do |method_name, type|
        define_method method_name do
          @data[:geo][method_name.to_s]
        end
      end
    end
  end
end
