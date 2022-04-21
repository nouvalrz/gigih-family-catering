class OrderSerializer
  include JSONAPI::Serializer
  attributes :customer_email, :total_price, :order_date, :status

  has_many :order_details 
  # has_many :menus, through: :order_details
end
