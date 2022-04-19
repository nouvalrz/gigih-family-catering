class Menu < ApplicationRecord
    has_many :menu_categories
    validates :name, presence: true
    validates :price, presence: true
end
