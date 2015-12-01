module ISO3166
  module Countries
    module AttrReaders
      AttrReaders = [
        :number,
        :alpha2,
        :alpha3,
        :name,
        :names,
        :latitude,
        :longitude,
        :continent,
        :region,
        :subregion,
        :world_region,
        :country_code,
        :national_destination_code_lengths,
        :national_number_lengths,
        :international_prefix,
        :national_prefix,
        :address_format,
        :translations,
        :translated_names,
        :ioc,
        :gec,
        :un_locode,
        :languages,
        :nationality,
        :dissolved_on,
        :eu_member,
        :alt_currency,
        :vat_rates,
        :postal_code,
        :min_longitude,
        :min_latitude,
        :max_longitude,
        :max_latitude,
        :latitude_dec,
        :longitude_dec
      ]

      AttrReaders.each do |meth|
        define_method meth do
          @data[meth.to_s]
        end
      end
    end
  end
end
