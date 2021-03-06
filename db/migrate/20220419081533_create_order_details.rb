class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details do |t|
      t.belongs_to :order, null: false, foreign_key: true
      t.belongs_to :menu, null: false, foreign_key: true
      t.float :menu_price
      t.integer :quantity
      t.float :subtotal

      t.timestamps
    end
  end
end
