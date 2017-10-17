class AddIndexForDbseed < ActiveRecord::Migration[5.1]
  def change
    add_index :senkyokus, [:pref_code, :senkyoku_no], unique: true
    remove_column :zip_codes, :created_at, :datetime
    remove_column :zip_codes, :updated_at, :datetime
  end
end
