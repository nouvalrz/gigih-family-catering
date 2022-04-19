FactoryBot.define do
  factory :menu_category do
    association :menu, factory: :menu
    association :category, factory: :category
  end
end
