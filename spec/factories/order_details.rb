FactoryBot.define do
  factory :order_detail do
    association :order, factory: :order
    association :menu, factory: :menu
    menu_price { nil }
    quantity { nil }
    subtotal { nil }
  end
end
