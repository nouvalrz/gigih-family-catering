class Api::V1::OrdersController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    orders = Order.all
    render json: OrderSerializer.new(orders, options).serializable_hash.to_json 
  end

  def show
    @order = Order.find_by(id: params[:id])
    unless @order.nil?
      render json: OrderSerializer.new(@order, options).serializable_hash.to_json 
    else
      head :not_found
    end
  end

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
  
  def update_status
    order = Order.find_by(id: params[:id])
    if (["PAID","NEW","CANCELED"].include? params.require(:status)) && (Order.find_by(id: params[:id]).present?)
      order.update(params.permit(:status))
      render json: OrderSerializer.new(order).serializable_hash.to_json, status: :ok
    else
      render json: {status: "is invalid or order not exits"}, status: :unprocessable_entity
    end
  end

  def update_status_all
    Order.update_status_order
    render json: {status: "SUCCESS"}, status: :ok
  end

  def destroy
    order = Order.find_by(id: params[:id])
    if order.nil?
      render json: {status: "NOT EXIST"}, status: :unprocessable_entity
    else
      order.order_details.destroy_all
      order.destroy
      render json: {status: "SUCCESS"}, status: :ok
    end
  end

  private
  def order_params
    params.require(:order).permit(:customer_email)
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