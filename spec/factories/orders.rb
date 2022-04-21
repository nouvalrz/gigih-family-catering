FactoryBot.define do
  factory :order do
    customer_email { Faker::Internet.email }
    order_date { Faker::Date.between(from: Date.today, to: '2022/04/30').strftime("%d/%m/%Y") }
  end
end
