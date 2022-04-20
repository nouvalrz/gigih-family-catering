class MenuCategory < ApplicationRecord
  belongs_to :menu, optional: true
  belongs_to :category, optional: true
  validates :menu, uniqueness: {scope: :category, message: "already has that category"}
  # validates :menu_id, presence: true
  # validates :category_id, presence: true
end
