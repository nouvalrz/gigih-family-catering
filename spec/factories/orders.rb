FactoryBot.define do
  factory :order do
    customer_email { "MyString" }
    order_date { "2022-04-19" }
    status { "MyString" }
  end
end
