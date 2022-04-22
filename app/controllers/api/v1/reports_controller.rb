class Api::V1::ReportsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    unless filtering_params(params).empty?
      orders = Order.where(nil)
      filtering_params(params).each do |key, value|
        orders = orders.public_send("filter_by_#{key}", value) if value.present?
      end
    else
      orders = Order.where(created_at: Date.today.all_day)
    end
    render json: NestedOrderSerializer.new(orders).serializable_hash.to_json, status: :created
  end

  def show
    @order = Order.find_by(id: params[:id])
    unless @order.nil?
      render json: OrderSerializer.new(@order, options).serializable_hash.to_json 
    else
      head :not_found
    end
  end

  def filtering_params(params)
    params.slice(:customer_email, :start_price, :end_price, :start_date, :end_date)
  end

  def options
    options = {
      include: [:order_details]
    }
  end
end