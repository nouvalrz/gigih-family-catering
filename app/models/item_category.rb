class ItemCategory < ApplicationRecord
  belongs_to :menuitem
  belongs_to :category
end
