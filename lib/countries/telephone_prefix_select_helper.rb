module ActionView
  module Helpers
    module FormOptionsHelper

      def telephone_prefix_select(object, method, priority_telephone_prefixes = nil, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_telephone_prefix_select_tag(priority_telephone_prefixes, options, html_options)
      end

      def telephone_prefix_options_for_select(selected = nil, priority_telephone_prefixes = nil)
        telephone_prefix_options = "".html_safe

        if priority_telephone_prefixes
          priority_telephone_prefixes = [*priority_telephone_prefixes].map {|x| [x.html_safe,ISO3166::Country::NameIndex[x]] }
          telephone_prefix_options += options_for_select(priority_telephone_prefixes, selected)
          telephone_prefix_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n"
        end

        telephone_prefixes = ISO3166::Country::Names.map{ |(name,alpha2)| c = Country[alpha2]; [name.html_safe, c.country_code.to_s.html_safe] }

        return telephone_prefix_options + options_for_select(telephone_prefixes, selected)
      end
    end

    class InstanceTag
      def to_telephone_prefix_select_tag(priority_telephone_prefixes, options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = options.delete(:selected) || value(object)
        content_tag("select",
          add_options(
            telephone_prefix_options_for_select(value, priority_telephone_prefixes),
            options, value
          ), html_options
        )
      end
    end

    class FormBuilder
      def telephone_prefix_select(method, priority_telephone_prefixes = nil, options = {}, html_options = {})
        @template.telephone_prefix_select(@object_name, method, priority_telephone_prefixes, options.merge(:object => @object), html_options)
      end
    end
  end
end
