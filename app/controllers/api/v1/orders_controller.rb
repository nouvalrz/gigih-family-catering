class Api::V1::OrdersController < ApplicationController
  protect_from_forgery with: :null_session


  def index
    query_params = request.query_parameters
    customer_email = query_params[:email].present? ? query_params[:email] : nil
    more_than_price = query_params[:morethan].present? ? query_params[:morethan] : nil
    less_than_price = query_params[:lessthan].present? ? query_params[:lessthan] : nil
    start_date = query_params[:start_date].present? ? query_params[:start_date] : nil
    end_date = query_params[:end_date].present? ? query_params[:end_date] : nil

    orders = Order.filter_by_email(customer_email)

    render json: OrderSerializer.new(orders, options).serializable_hash.to_json, status: :created

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