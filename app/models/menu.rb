class Menu < ApplicationRecord
  has_many :menu_categories
  has_many :categories, through: :menu_categories
  validates :name, presence: true, uniqueness: true, length: { maximum: 150,
    too_long: "%{count} characters is the maximum allowed" }
  validates :price, presence: true, comparison: { greater_than_or_equal_to: 0.01 }
end
