module ISO3166
  ##
  # Handles building the in memory store of countries data
  class Setup
    def codes
      @codes ||= load(['data', 'countries.yaml'])
    end

    def translations
      @translations ||= load(['cache', 'translations.yaml'])
    end

    def names
      @names ||= I18nData.countries.values.sort_by { |d| d[0] }
    end

    def data
      return @data if @data
      @data = {}
      codes.each do |alpha2|
        @data[alpha2] = load(['data', 'countries', "#{alpha2}.yaml"])[alpha2]
        @data[alpha2] = @data[alpha2].merge(translations[alpha2])
      end
      @data
    end

    private

    def datafile_path(file_array)
      File.join([File.dirname(__FILE__), '..'] + file_array)
    end

    def load(file_array)
      YAML.load_file(datafile_path(file_array))
    end
  end
end
