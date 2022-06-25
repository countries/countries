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
      attrs.each_pair do |k, v|
        send "#{k}=", v
      end
    end

    def [](attr_name)
      send attr_name
    end
  end
end
