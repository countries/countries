# frozen_string_literal: true

module ISO3166
  module SubdivisionMethods
    def subdivision_data(alpha2)
      locales = ISO3166.configuration.locales.map(&:to_s)
      load_data_for_alpha2(alpha2).transform_values do |subdivision|
        translations = subdivision['translations'].slice(*locales).transform_keys(&:to_sym)
        subdivision.merge('translations' => translations)
      end
    end

    def load_data_for_alpha2(alpha2)
      file = subdivision_file_path(alpha2)
      File.exist?(file) ? YAML.load_file(file, freeze: true) : {}
    end

    def subdivisions(alpha2)
      @subdivisions ||= {}
      @subdivisions[alpha2] ||= create_subdivisions(subdivision_data(alpha2))
    end

    # :reek:UtilityFunction
    def create_subdivisions(subdivision_data)
      subdivision_data.transform_values do |subdivision|
        Subdivision.new(subdivision)
      end
    end
  end
end
