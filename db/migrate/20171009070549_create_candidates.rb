class CreateCandidates < ActiveRecord::Migration[5.1]
  def change
    create_table :candidates do |t|
      t.string :name_first, null: false
      t.string :name_last, null: false
      t.string :name_first_furigana
      t.string :name_last_furigana

      t.integer :party_id
      t.integer :senkyoku_id

      t.integer :gender

      t.date :birth_day
      t.integer :birth_year

      t.string :twitter_id
      t.string :facebook_id
      t.string :official_website_url

      t.string :photo_url

      t.timestamps
    end
  end
end
