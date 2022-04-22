class OrderSerializer
  include JSONAPI::Serializer
  attributes :customer_email, :total_price, :status, :created_at, :updated_at

  has_many :order_details 
  # has_many :menus, through: :order_details
end
