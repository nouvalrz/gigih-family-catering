class OrderDetailSerializer
  include JSONAPI::Serializer
  attributes :menu_id, :menu_name, :menu_price, :quantity, :subtotal
  # belongs_to :menu
  # belongs_to :order
end
