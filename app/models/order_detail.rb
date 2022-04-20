class OrderDetail < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :menu, optional: true

  def sum_subtotal
    subtotal = menu_price * quantity
  end
end
