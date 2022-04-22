class Order < ApplicationRecord
  has_many :order_details 
  has_many :menus, through: :order_details

  scope :filter_by_customer_email, -> (customer_email) { where(customer_email: customer_email) }
  scope :filter_by_start_price, -> (start_price) { where('total_price >= ?', start_price) }
  scope :filter_by_end_price, -> (end_price) { where('total_price <= ?', end_price) }
  scope :filter_by_start_date, -> (start_date) { where("date(created_at) >= date(?)", start_date) }
  scope :filter_by_end_date, -> (end_date) { where("date(created_at) <= date(?)", end_date) }

  validates :customer_email, presence: true, format: { with: /\A([^\}\{\]\[@\s\,]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , message: "not valid" }


  before_create :sum_subtotal
  before_create :sum_total_price

  before_update :sum_subtotal
  before_update :sum_total_price

  def self.update_status_order
    Order.where(status: 'NEW').update_all(status: 'CANCELED')
  end

  def add_menus(menus)
    if menus.nil? || menus.size == 0
      self.errors.add(:order, "must atleast have 1 menu")
      return
    end
    menus.each do |menu|
      if Menu.active_data.where(id: menu[:id]).present?
        self.order_details << OrderDetail.new(menu_id: menu[:id], quantity: menu[:quantity], menu_price: Menu.active_data.where(id: menu[:id])[0].price)
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


end
