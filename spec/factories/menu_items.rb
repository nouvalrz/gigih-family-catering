FactoryBot.define do
  factory :menu_item do
    name { "MyString" }
    price { 1.5 }
    description { "MyText" }
    is_deleted { 1 }
  end
end
