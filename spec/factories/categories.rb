FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "#{Faker::Food.ethnic_category} #{n}"[0..10] }
  end
end
