namespace :countries do
  desc "Update the country definitions"
  task :update do |_|
    perform do |_|
      if Country.first.version == Countries::VERSION
        puts "You have already ran the update for this version (#{Countries::VERSION})"
        return
      end

      Country.destroy_all
      ISO3166::Country.all.each do |_, alpha2|
        Country.create alpha2: alpha2, version: Countries::VERSION
      end
      puts "All countries created."
    end
  end
end
