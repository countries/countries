# Extend Country class with support for timezones
module ISO3166
  # Extend Country class with support for timezones
  module TimezoneExtensions
    def timezones
      @tz_country ||= TZInfo::Country.get(alpha2)
    end
  end
end

ISO3166::Country.send(:include, ISO3166::TimezoneExtensions)
