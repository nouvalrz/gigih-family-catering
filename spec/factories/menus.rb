FactoryBot.define do
  factory :menu do
    name { Faker::Food.dish }
    price { Faker::Commerce.price }
    description { Faker::Food.description }
    is_deleted { 0 }
  end
end
