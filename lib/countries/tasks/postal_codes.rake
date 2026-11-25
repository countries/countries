# frozen_string_literal: true

namespace :postal_codes do
  desc 'Retrieve and update postal codes, their format and an example'
  task :update do
    require 'json'
    require 'open-uri'
    require 'yaml'

    country_files = Dir['lib/countries/data/countries/*.yaml']

    country_files.each do |country_file|
      yaml = YAML.load_file(country_file)
      country_code = File.basename(country_file, File.extname(country_file))
      print "\rUpdating #{country_code}"

      data = yaml[country_code].to_a
      postal_code_index = data.find_index { |d| d[0] == 'postal_code' }

      response = URI.open("https://chromium-i18n.appspot.com/ssl-address/data/#{country_code}").read
      json = begin
        JSON.parse(response)
      rescue StandardError
        {}
      end
      if json.empty?
        puts ' - Returned empty data. Skipping'
        next
      end

      postal_code = ['postal_code', !json['zip'].nil?]

      if postal_code_index
        data[postal_code_index] = postal_code
      else
        postal_code_index = (data.find_index { |d| d[0] == 'nationality' } + 1) || data.size
        data.insert(postal_code_index, postal_code)
      end

      # zipex lists several examples separated by commas: keep the first one
      postal_code_details = {
        'postal_code_format' => json['zip'],
        'postal_code_example' => json['zip'] && json['zipex']&.split(',').first
      }
      postal_code_details.each.with_index(1) do |(key, value), offset|
        index = data.find_index { |d| d[0] == key }

        if value.nil?
          data.delete_at(index) if index
        elsif index
          data[index] = [key, value]
        else
          data.insert(postal_code_index + offset, [key, value])
        end
      end

      yaml[country_code] = data.to_h

      File.write(country_file, yaml.to_yaml(line_width: -1))
    end
  end
end
