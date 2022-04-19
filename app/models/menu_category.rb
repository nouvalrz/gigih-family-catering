class MenuCategory < ApplicationRecord
  belongs_to :menu
  belongs_to :category
  validates :menu, uniqueness: {scope: :category, message: "Menu already has that category"}
  validates :menu_id, presence: true
  validates :category_id, presence: true
end
