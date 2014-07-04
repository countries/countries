require 'rails/generators/migration'

module ISO3166
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "Add the migrations"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_files.each do |migration_file|
          migration_template migration_file, "db/migrate/#{migration_file}"
        end
      end

      def migration_files
        [ "create_countries.rb",
          "change_alpha2_type_in_countries.rb"
        ]
      end

    end
  end
end
