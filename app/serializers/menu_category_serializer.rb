class MenuCategorySerializer
  include JSONAPI::Serializer
  attributes :menu_id, :category_id
  belongs_to :menu
  belongs_to :category
end
