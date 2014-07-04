class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries, :id => false do |t|
      t.primary_key :alpha2
      t.string      :version

      t.timestamps
    end
  end
end
