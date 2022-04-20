class ChangeOrderDetailDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column :order_details, :quantity, :integer, :default => 0
    change_column :order_details, :subtotal, :float, :default => 0.0

  end
end
