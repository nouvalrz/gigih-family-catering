require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:order_detail)).to be_valid
  end

  it 'calculate the subtotal by multiplying the price by the quantity' do
    order_detail = FactoryBot.create(:order_detail)
    order_detail
  end
end
