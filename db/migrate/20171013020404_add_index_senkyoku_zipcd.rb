class AddIndexSenkyokuZipcd < ActiveRecord::Migration[5.1]
  def change
    add_index :senkyokus_zip_codes, [:zip_code_id, :senkyoku_id], unique: true
  end
end
