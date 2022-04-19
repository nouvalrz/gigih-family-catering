FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "#{Faker::String.random(length: 10)} #{n}" }
  end
end
