# frozen_string_literal: true

# Extend Country class with support for timezones
module ISO3166
  # Extend Country class with support for timezones
  module TimezoneExtensions
    # TODO: rename method to tz_country or something similar
    def timezones
      @timezones ||= TZInfo::Country.get(alpha2)
    end
  end
end

ISO3166::Country.include ISO3166::TimezoneExtensions
