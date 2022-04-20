class Api::V1::MenusController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    menus = Menu.all
    render json: MenuSerializer.new(menus, options).serializable_hash.to_json
  end
  def show
    @menu = Menu.find_by(id: params[:id])
    render json: MenuSerializer.new(@menu, options).serializable_hash.to_json
  end

  private
  def options
    options = {
      include: [:categories]
    }
  end
end