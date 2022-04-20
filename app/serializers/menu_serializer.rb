class MenuSerializer
  include JSONAPI::Serializer
  attributes :name, :price, :description

  has_many :categories, through: :menu_categories
end
