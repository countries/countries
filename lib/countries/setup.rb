module ISO3166
  ##
  # Handles building the in memory store of countries data
  class Setup
    def codes
      @codes ||= Data.codes
    end

    def data
      return @data if instance_variable_defined?('@data')
      @data = {}
      codes.each do |alpha2|
        @data[alpha2] = Data.new(alpha2).call
      end
      @data.freeze
    end
  end
end
