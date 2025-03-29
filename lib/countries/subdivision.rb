# frozen_string_literal: true

module ISO3166
  class Subdivision
    attr_accessor :name,
                  :code,
                  :unofficial_names,
                  :geo,
                  :translations,
                  :comments,
                  :type

    def initialize(attrs)
      attrs.each_pair do |key, value|
        send "#{key}=", value
      end
    end

    def [](attr_name)
      send attr_name
    end

    # @return [Hash] A hash with the subdivision code as key and the hash of translated subdivision names ( locale => name ) as value.
    def code_with_translations
      { code => translations }
    end

    def match?(subdivision_str)
      name == subdivision_str ||
        translations.values.include?(subdivision_str)
    end
  end
end
