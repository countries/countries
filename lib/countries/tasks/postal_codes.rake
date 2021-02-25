namespace :postal_codes do
  desc 'Retrieve and update postal codes and their format'
  task :update do
    require 'json'
    require 'open-uri'
    require 'yaml'

    country_files = Dir['lib/countries/data/countries/*.yaml'].sort

    country_files.each do |country_file|
      yaml = YAML.load_file(country_file)
      country_code = File.basename(country_file, File.extname(country_file))
      print "\rUpdating #{country_code}"

      data = yaml[country_code].to_a
      postal_code_index = data.find_index { |d| d[0] == 'postal_code' }
      postal_code_format_index = data.find_index { |d| d[0] == 'postal_code_format' }

      response = URI.open("https://chromium-i18n.appspot.com/ssl-address/data/#{country_code}").read
      json = JSON.parse(response) rescue {}
      puts ' - Returned empty data. Skipping ' and next if json.empty?

      postal_code = ['postal_code', !!json['zip']]
      postal_code_format = ['postal_code_format', json['zip']]

      if postal_code_index
        data[postal_code_index] = postal_code
      else
        postal_code_index = data.find_index { |d| d[0] == 'nationality' } + 1 || data.size
        data.insert(postal_code_index, postal_code)
      end

      if json['zip']
        if postal_code_format_index
          data[postal_code_format_index] = postal_code_format
        else
          data.insert(postal_code_index + 1, postal_code_format)
        end
      elsif postal_code_format_index
        data.delete_at(postal_code_format_index)
      end

      yaml[country_code] = data.to_h

      File.open(country_file, 'w') { |file| file.write(yaml.to_yaml) }
    end
  end
end
