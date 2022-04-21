require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  it 'has a valid factory' do
    menu = FactoryBot.create(:menu)
    order = FactoryBot.create(:order)
    order_detail = OrderDetail.create(order_id: order.id, menu_id: menu.id, quantity: 2)
    expect(order_detail).to be_valid
  end

  it 'calculate the subtotal by multiplying the price by the quantity' do
    menu = FactoryBot.create(:menu)
    order = FactoryBot.create(:order)
    order_detail = OrderDetail.create(order_id: order.id, menu_id: menu.id, quantity: 2)
    order_detail.sum_subtotal
    expect(order_detail.subtotal).to eq(order_detail.menu_price * order_detail.quantity)
  end

  it 'find the menu name from menu_id' do
    menu = FactoryBot.create(:menu)
    order = FactoryBot.create(:order)
    order_detail = OrderDetail.create(order_id: order.id, menu_id: menu.id, quantity: 2)
    expect(order_detail.menu_name). to eq(menu.name)
  end
end
