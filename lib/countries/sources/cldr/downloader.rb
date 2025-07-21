# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'nokogiri'
require 'fileutils'
require 'json'
require 'open-uri'
require 'zip'

# Support code to allow updating subdivision data from the Unicode CLDR repository
module Sources
  # Support code to allow updating subdivision data from the Unicode CLDR repository
  module CLDR
    # Downloads data from the Unicode CLDR repository
    module Downloader
      module_function

      # URL to the latest CLDR release info
      CLDR_RELEASES_URL = 'https://api.github.com/repos/unicode-org/cldr/releases/latest'
      # Name of the asset containing the CLDR core data
      CLDR_ZIP_BASENAME = 'core.zip'

      def subdivisions
        download_and_extract_zip('subdivisions')
      end

      def download_and_extract_zip(type)
        folder = File.join(ISO3166_ROOT_PATH, 'tmp', 'cldr', 'trunk', 'common', type)
        FileUtils.mkdir_p(folder)
        zip_path = File.join(ISO3166_ROOT_PATH, 'tmp', 'cldr', CLDR_ZIP_BASENAME)

        puts 'Fetching latest CLDR release info...'
        release_info = JSON.parse(URI.open(CLDR_RELEASES_URL).read)
        asset = release_info['assets'].find { |a| a['name'] == CLDR_ZIP_BASENAME }
        raise 'Could not find core.zip asset in latest release.' unless asset
        puts "Downloading #{asset['browser_download_url']}..."
        URI.open(asset['browser_download_url']) do |remote_file|
          File.open(zip_path, 'wb') { |file| file.write(remote_file.read) }
        end

        puts 'Extracting subdivision XML files from CLDR ZIP...'
        Zip::File.open(zip_path) do |zip_file|
          zip_file.each do |entry|
            next unless entry.name =~ %r{^common/#{type}/.+\.xml$}
            target = File.join(folder, File.basename(entry.name))
            entry.extract(target) { true }
          end
        end
      end
    end
  end
end
