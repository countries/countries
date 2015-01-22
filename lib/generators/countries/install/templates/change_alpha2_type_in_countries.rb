class ChangeAlpha2TypeInCountries < ActiveRecord::Migration
  def change
    change_column :countries, :alpha2, :string, limit: 4
  end
end
