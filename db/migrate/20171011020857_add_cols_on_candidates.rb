class AddColsOnCandidates < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :is_candidate, :boolean
    add_column :candidates, :current_position, :integer
    add_column :candidates, :submission_order, :integer
    add_column :candidates, :is_hirei, :boolean
    add_column :candidates, :winning_history, :string
  end
end
