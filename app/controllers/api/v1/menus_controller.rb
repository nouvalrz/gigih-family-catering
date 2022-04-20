class Api::V1::MenusController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    menus = Menu.all
    options = {
      include: [:categories]
    }
    render json: MenuSerializer.new(menus, options).serializable_hash.to_json
  end
end