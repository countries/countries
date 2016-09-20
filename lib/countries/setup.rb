module ISO3166
  ##
  # <b>DEPRECATED:</b> Please use <tt>Data</tt> instead.
  # TODO: Remove at version 2.1
  # Handles building the in memory store of countries data
  class Setup
    # <b>DEPRECATED:</b> Please use <tt>Data.codes</tt> instead.
    def codes
      warn '[DEPRECATION] `Setup.codes` is deprecated.  Please use `Data.codes` instead.'
      Data.codes
    end

    def data
      warn "[DEPRECATION] `Setup.new.data` is deprecated without replacement
      data is now loaded per locale Data.new(:en).call"
    end
  end
end
