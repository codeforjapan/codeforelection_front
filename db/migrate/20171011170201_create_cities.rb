class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :city_code, null: false
      t.string :pref_code, null: false
      t.string :city_name, null: false

      t.index :city_code, unique: true

      t.timestamps
    end

    add_column :zip_codes, :city_id, :integer
  end
end
