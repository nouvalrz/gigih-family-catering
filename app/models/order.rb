class Order < ApplicationRecord
  has_many :order_details 
  has_many :menus, through: :order_details
  
  def add_menus(menus)
    menus.each do |menu|
      self.order_details << OrderDetail.new(menu_id: menu[:id], quantity: menu[:quantity], menu_price: Menu.find_by_id(menu[:id]).price)
    end
  end

  def sum_subtotal
    self.order_details.each do |order_detail|
      order_detail.sum_subtotal
    end
  end

  def sum_total_price
    self.order_details.each do |order_detail|
      self.total_price = self.total_price + order_detail.subtotal
    end
  end

end
