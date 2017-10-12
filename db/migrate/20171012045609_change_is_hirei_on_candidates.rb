class ChangeIsHireiOnCandidates < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :hirei_area_id, :integer
    remove_column :candidates, :is_hirei, :boolean
  end
end
