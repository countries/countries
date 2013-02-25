# CountrySelect - stolen from http://github.com/rails/iso-3166-country-select
module ActionView
  module Helpers
    module FormOptionsHelper

      def country_select(object, method, priority_countries = nil, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_country_select_tag(priority_countries, options, html_options)
      end

      def country_options_for_select(selected_country_code = nil, priority_countries = nil)
        country_options = ""

        if priority_countries
          priority_countries = [*priority_countries].map { |x| [x,ISO3166::Country::NameIndex[x]] }
          country_options += options_for_select(priority_countries, selected_country_code)
          country_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n"

          # prevent selected_country_code from being included twice in the HTML which causes
          # some browsers to select the second selected option (not priority)
          # which makes it harder to select an alternative priority country
          if selected_country = ISO3166::Country[selected_country_code]
            selected_country_code = nil if priority_countries.include?([selected_country.name, selected_country_code])
          end
        end

        country_options = country_options.html_safe if country_options.respond_to?(:html_safe)
        countries = ISO3166::Country::Names.map{ |(name,alpha2)| [name.html_safe,alpha2] }

        country_options + options_for_select(countries, selected_country_code)
      end
    end

    class InstanceTag
      def to_country_select_tag(priority_countries, options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = options.delete(:selected) || value(object)
        content_tag("select",
          add_options(
            country_options_for_select(value, priority_countries),
            options, value
          ), html_options
        )
      end
    end

    class FormBuilder
      def country_select(method, priority_countries = nil, options = {}, html_options = {})
        @template.country_select(@object_name, method, priority_countries, options.merge(:object => @object), html_options)
      end
    end
  end
end
