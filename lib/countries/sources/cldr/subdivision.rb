module Sources
  module CLDR
    class Subdivision
      attr_reader :xml, :language_code
      def initialize(language_code:, xml:)
        @language_code = language_code
        @xml = xml
      end

      def text
        xml.text
      end

      def country_code
        type[0..1].upcase
      end

      def code
        type[2..-1].upcase
      end

      def type
        xml.attributes['type'].value.delete('-')
      end

      def to_h
        data = {}
        data['translations'] ||= {}
        data['translations'][language_code] = text
        data
      end
    end
  end
end
