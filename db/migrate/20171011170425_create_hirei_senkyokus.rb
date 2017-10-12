class CreateHireiSenkyokus < ActiveRecord::Migration[5.1]
  def change
    create_table :hirei_senkyokus do |t|
      t.string :name
      t.integer :capacity

      t.timestamps
    end
  end
end
