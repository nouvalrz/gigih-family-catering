class ChangeMenuPriceDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column :order_details, :menu_price, :float, :default => 0.0
  end
end
