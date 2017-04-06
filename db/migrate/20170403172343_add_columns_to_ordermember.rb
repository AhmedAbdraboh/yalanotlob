class AddColumnsToOrdermember < ActiveRecord::Migration[5.0]
  def change
    add_column :ordermembers, :item, :string
    add_column :ordermembers, :amount, :integer
    add_column :ordermembers, :price, :integer
    add_column :ordermembers, :comment, :string
  end
end
