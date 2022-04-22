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
    category = Category.new(name: category_params[:name])
    if category.save
      render json: CategorySerializer.new(category).serializable_hash.to_json, status: :created
    else
      render json: ErrorSerializer.serialize(category.errors), status: :unprocessable_entity
    end
  end
  def update
    category = Category.find_by(id: params[:id])
    if category.update(name: category_params[:name])
      render json: CategorySerializer.new(category).serializable_hash.to_json, status: 200
    else
      render json: ErrorSerializer.serialize(category.errors), status: :unprocessable_entity
    end
  end
  def destroy
    category = Category.find_by(id: params[:id])
    if category.nil?
      head :unprocessable_entity
    else
      category.destroy
      head :no_content
    end
  end
  private
  def category_params
    params.permit(:name)
  end
end
