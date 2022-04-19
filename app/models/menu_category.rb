class MenuCategory < ApplicationRecord
  belongs_to :menu
  belongs_to :category
  validates :menu, uniqueness: {scope: :category, message: "Menu already has that category"}
end
