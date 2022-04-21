FactoryBot.define do
  factory :order_detail do
    association :order, factory: :order
    association :menu, factory: :menu
    menu_price { nil }
    quantity { Faker::Number.between(from: 20, to: 100) }
    subtotal { nil }
  end
end
