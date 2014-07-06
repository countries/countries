namespace :countries do
  desc "Update the country definitions"
  task :update => :environment do
    if Country.count > 0 && Country.first.version == Countries::VERSION
      abort "You have already ran the update for this version (#{Countries::VERSION})"
    end

    Country.destroy_all
    ISO3166::Country.all.each do |_, alpha2|
      Country.create alpha2: alpha2, version: Countries::VERSION
    end
    puts "Done, all country records created."
  end
end
