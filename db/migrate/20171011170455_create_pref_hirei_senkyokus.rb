class CreatePrefHireiSenkyokus < ActiveRecord::Migration[5.1]
  def change
    create_join_table :prefs, :hirei_senkyokus
  end
end
