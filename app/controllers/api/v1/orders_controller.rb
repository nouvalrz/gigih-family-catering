class Api::V1::OrdersController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    order = Order.new(order_params)
    order.add_menus(order_menu_params[:menus])
    if order.errors.messages.empty? && order.save
      render json: OrderSerializer.new(order, options).serializable_hash.to_json, status: :created
    else
      render json: ErrorSerializer.serialize(order.errors), status: :unprocessable_entity
    end
  end

  def update
    order = Order.find_by(id: params[:id])
    order.update(order_params)
    order.order_details.destroy_all
    order.add_menus(order_menu_params[:menus])
    if order.errors.messages.empty? && order.update(order_params)
      render json: OrderSerializer.new(order, options).serializable_hash.to_json, status: :created
    else
      render json: ErrorSerializer.serialize(order.errors), status: :unprocessable_entity
    end
  end

  def destroy
    order = Order.find_by(id: params[:id])
    if order.nil?
      head :unprocessable_entity
    else
      order.order_details.destroy_all
      order.destroy
      head :no_content
    end
  end

  private
  def order_params
    params.require(:order).permit(:customer_email, :order_date)
  end

  def order_menu_params
    params.require(:order).permit(menus: [:id, :quantity])
  end

  def options
    options = {
      include: [:order_details]
    }
  end

end