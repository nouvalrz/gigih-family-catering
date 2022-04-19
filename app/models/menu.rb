class Menu < ApplicationRecord
    has_many :menu_categories
    validates :name, presence: true, uniqueness: true, length: { maximum: 150,
        too_long: "%{count} characters is the maximum allowed" }
    validates :price, presence: true
end
