FactoryBot.define do
  factory :menu do
    sequence(:name) { |n| "#{Faker::Food.dish} #{n}" }
    price { Faker::Commerce.price }
    description { Faker::Food.description }
    is_deleted { 0 }
  end
end
