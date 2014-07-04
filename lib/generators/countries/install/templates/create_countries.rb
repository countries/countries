class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries, :id => false do |t|
      t.string :alpha2, limit: 4
      t.primary_key :alpha2

      t.timestamps
    end
  end
end
