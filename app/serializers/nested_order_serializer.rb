class NestedOrderSerializer
  include JSONAPI::Serializer
  attributes :customer_email, :total_price, :status, :created_at, :updated_at, :order_details

  set_type :order
end
