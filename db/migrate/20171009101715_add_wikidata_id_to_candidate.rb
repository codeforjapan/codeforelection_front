class AddWikidataIdToCandidate < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :wikidata_id, :string
  end
end
