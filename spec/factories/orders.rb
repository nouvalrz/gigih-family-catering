FactoryBot.define do
  factory :order do
    customer_email { Faker::Internet.email }
  end
end
