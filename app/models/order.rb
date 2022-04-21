class Order < ApplicationRecord
  has_many :order_details 
  has_many :menus, through: :order_details
  validates :customer_email, presence: true, format: { with: /\A([^\}\{\]\[@\s\,]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , message: "not valid" }
  validates :order_date, presence: :true

  after_initialize :order_date_past_check

  before_create :sum_subtotal
  before_create :sum_total_price

  before_save :order_date_past_check

  def self.update_status_order
    Order.where(status: 'UNPAID').update_all(status: 'CANCELED')
  end

  def add_menus(menus)
    if menus.nil? || menus.size == 0
      self.errors.add(:order, "must atleast have 1 menu")
      return
    end
    menus.each do |menu|
      if Menu.find_by_id(menu[:id]).present?
        self.order_details << OrderDetail.new(menu_id: menu[:id], quantity: menu[:quantity], menu_price: Menu.find_by_id(menu[:id]).price)
      else
        self.errors.add(:menu, "with id: #{menu[:id]} is not exits")
      end
      self.errors.add(:menu, "quantity must more than 0") if menu[:quantity].to_i < 1
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

  def order_date_past_check
    self.errors.add(:order_date, "is past") if order_date.present? && order_date < Date.today
  end

end
