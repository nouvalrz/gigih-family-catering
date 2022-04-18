class Api::V1::CategoriesController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    categories = Category.all
    render json: CategorySerializer.new(categories).serializable_hash.to_json
  end
  def show
    @category = Category.find_by(id: params[:id])
    render json: CategorySerializer.new(@category).serializable_hash.to_json
  end
  def create
    category = Category.new(category_params)
    if category.save
      render json: CategorySerializer.new(category).serializable_hash.to_json
    else
      render json: ErrorSerializer.serialize(category.errors)
    end
  end

  private
  def category_params
    params.require(:data)
          .require(:attributes)
          .permit(:name)
  end
end
