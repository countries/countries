require 'uri'
require 'net/http'
require 'nokogiri'
require 'fileutils'
module Sources
  module CLDR
    module Downloader
      module_function

      def subdivisions
        download_folder('subdivisions')
      end

      def download_folder(type)
        folder = File.join(ISO3166_ROOT_PATH, 'tmp', 'cldr', 'trunk', 'common', type)
        FileUtils.mkdir_p(folder)
        doc = Nokogiri::HTML get(type + '/')
        doc.css('a[href]').map { |e| e.attributes['href'].value }.each do |href|
          next if href == '../'
          File.write(File.join(folder, href), get([type, href].join('/')))
        end
      end

      def get(path)
        url = URI("http://www.unicode.org/repos/cldr/trunk/common/#{path}")

        http = Net::HTTP.new(url.host, url.port)

        request = Net::HTTP::Get.new(url)
        response = http.request(request)
        response.read_body
      end
    end
  end
end
