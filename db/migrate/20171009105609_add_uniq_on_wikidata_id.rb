class AddUniqOnWikidataId < ActiveRecord::Migration[5.1]
  def change
    add_index :candidates, :wikidata_id, unique: true
  end
end
