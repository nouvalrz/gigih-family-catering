class Api::V1::MenusController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    menus = Menu.where(is_deleted: 0)
    render json: MenuSerializer.new(menus, options).serializable_hash.to_json
  end
  def show
    @menu = Menu.where(id: params[:id]).where(is_deleted: 0)
    unless @menu.empty?
      render json: MenuSerializer.new(@menu, options).serializable_hash.to_json 
    else
      render json: {status: "NOT EXITS"}, status: :not_found
    end
  end

  def create
    menu = Menu.new(menu_params)
    if menu.valid? && menu.category_exits?(menu_category_params)
      menu_category_params.each do |category| 
        menu.categories << Category.find_by_id(category[:id])
      end
      menu.save
      render json: MenuSerializer.new(menu, options).serializable_hash.to_json, status: :created
    else
      menu.errors.add(:menu, 'must have atleast one category') unless menu_category_params.present?
      render json: ErrorSerializer.serialize(menu.errors), status: :unprocessable_entity
    end
  end

  def update
    menu = Menu.find_by(id: params[:id])
    menu.categories.destroy_all
    if menu.update(menu_params) && menu.category_exits?(menu_category_params)
      menu_category_params.each do |category| 
        menu.categories << Category.find_by_id(category[:id])
      end
      render json: MenuSerializer.new(menu, options).serializable_hash.to_json, status: :created
    else
      menu.errors.add(:menu, 'must have atleast one category') unless menu_category_params.present?
      render json: ErrorSerializer.serialize(menu.errors), status: :unprocessable_entity
    end
  end

  def destroy
    menu = Menu.find_by(id: params[:id])
    if menu.nil?
      head :unprocessable_entity
    else
      menu.categories.destroy_all
      menu.update(is_deleted: 1)
      render json: {status: "SUCCESS"}, status: :ok
    end
  end

  private 
  def options
    options = {
      include: [:categories]
    }
  end
  def menu_params
    params.require(:menu).permit(:name, :price, :description)
  end
  def menu_category_params
    params.permit(menu: [ { categories: :id } ] )[:menu][:categories].presence || []
  end
end