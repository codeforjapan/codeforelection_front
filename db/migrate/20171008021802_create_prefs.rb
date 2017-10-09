class CreatePrefs < ActiveRecord::Migration[5.1]
  def change
    create_table :prefs do |t|
      t.string :pref_code, null: false
      t.string :name, null: false

      t.index :pref_code

      t.timestamps
    end
  end
end
