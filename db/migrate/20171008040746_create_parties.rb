class CreateParties < ActiveRecord::Migration[5.1]
  def change
    create_table :parties do |t|
      t.string :short_name, null:false
      t.string :full_name, null: false

      t.timestamps
    end
  end
end
