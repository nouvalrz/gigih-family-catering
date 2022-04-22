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
  context 'invalid parameters' do
    let(:order_invalid_email){FactoryBot.build(:order, customer_email: "nouvalr@gmail")}
    let(:order_invalid_date){Order.new(customer_email: "nouvalr@gmail.com")}
    let(:order){FactoryBot.create(:order)}
    it 'return error when customer_email not valid' do
      order_invalid_email.valid?
      expect(order_invalid_email.errors[:customer_email]).to include("not valid")
    end
    it 'return error when menus is not exits' do
      order.add_menus([{id: 19191919, quantity: 12}])
      expect(order.errors[:menu]).to include('with id: 19191919 is not exits')
    end
    it 'return error when menu quantity is not less than 1' do
      order.add_menus([{id: 1, quantity: -12}])
      expect(order.errors[:menu]).to include('quantity must more than 0')
    end
  end
end
