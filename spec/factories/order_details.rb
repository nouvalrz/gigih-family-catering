FactoryBot.define do
  factory :order_detail do
    order { nil }
    menuitem { nil }
    menuitem_price { 1.5 }
    quantity { 1 }
    subtotal { 1.5 }
  end
end
