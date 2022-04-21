require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:order)).to be_valid
  end
  context 'can calculate pricing' do
    let(:order){FactoryBot.create(:order, id: 5)}
    let(:menu1){FactoryBot.create(:menu, price: 199000.0)}
    let(:menu2){FactoryBot.create(:menu, price: 20000.0)}
    let(:quantity){12}
    before do 
      order.add_menus([{id: menu1.id, quantity: quantity}, {id: menu2.id, quantity: quantity}])
    end
    it 'store menu list params to order_detail association' do
      expect(order.menus).to eq([menu1, menu2])
    end
    it 'sum total price from all subtotal' do
      order.sum_subtotal
      order.sum_total_price
      expected_total_price = (menu1.price * quantity) + (menu2.price * quantity)
      expect(order.total_price).to eq(expected_total_price)
    end
  end
end
