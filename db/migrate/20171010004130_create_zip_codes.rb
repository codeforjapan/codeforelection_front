class CreateZipCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :zip_codes do |t|
      t.string :zip_code, null: false
      t.index :zip_code, unique: true
      t.timestamps
    end
    create_join_table :senkyokus, :zip_codes
    remove_column :senkyokus, :zip_code

    puts "*" * 22
    puts "データベースのスキーマが更新されましたので、以下のコマンドを発行下さい"
    puts "docker-compose run app rails db:drop"
    puts "docker-compose run app rails db:setup"
    puts "*" * 22

  end
end
