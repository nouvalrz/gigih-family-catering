class OrderDetail < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :menu, optional: true

  after_initialize :set_menu_name

  attr_accessor :menu_name

  def sum_subtotal
    self.subtotal = self.menu_price * self.quantity
  end

  def set_menu_name
    self.menu_name = Menu.find_by_id(self.menu_id).name
  end
end
