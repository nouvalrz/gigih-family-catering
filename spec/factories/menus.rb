FactoryBot.define do
  factory :menu do
    name { "MyString" }
    price { 1.5 }
    description { "MyText" }
    is_deleted { 0 }
  end
end
