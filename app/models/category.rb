class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 25,
    too_long: "%{count} characters is the maximum allowed" }
  has_many :menu_categories
end
