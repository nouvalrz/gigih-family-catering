FactoryBot.define do
  factory :order_detail do
    association :order
    association :menu
    menu_price { 1.5 }
    quantity { 1 }
    subtotal { 1.5 }
  end
end
