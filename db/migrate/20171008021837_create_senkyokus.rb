class CreateSenkyokus < ActiveRecord::Migration[5.1]
  def change
    create_table :senkyokus do |t|
      t.string :pref_code, null: false
      t.integer :senkyoku_no, null: false
      t.string :zip_code, null: false

      t.timestamps
    end
  end
end
