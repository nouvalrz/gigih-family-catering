class Api::V1::OrdersController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    order = order.new(order_params)
    order.add_menus(order_menus_param)

    puts order.menus
    # if order.valid? && order.category_exits?(order_category_params)
    #   order_category_params.each do |category| 
    #     order.categories << Category.find_by_id(category[:id])
    #   end
    #   order.save
    #   render json: OrderSerializer.new(order, options).serializable_hash.to_json, status: :created
    # else
    #   order.errors.add(:order, 'must have atleast one category') unless order_category_params.present?
    #   render json: ErrorSerializer.serialize(order.errors), status: :unprocessable_entity
    # end
  end

  private
  def order_params
    params.require(:order).permit(:customer_email, :order_date)
  end
  def order_menu_params
    params.permit(order: [ { menus: :id, menus: :quantity } ] )[:order][:menus].presence || []
  end

end