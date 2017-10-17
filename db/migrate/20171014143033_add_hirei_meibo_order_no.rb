class AddHireiMeiboOrderNo < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :hirei_meibo_order_no, :integer
  end
end
