class MenuSerializer
  include JSONAPI::Serializer
  attributes :name, :price, :description
end
