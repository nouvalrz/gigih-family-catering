require 'rails_helper'

RSpec.describe Menu, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:menu)).to be_valid
  end
  it 'is invalid without a name' do
    menu = FactoryBot.build(:menu, name: nil)
    menu.valid?
    expect(menu.errors[:name]).to include("can't be blank")
  end
  it 'is invalid without a price' do
    menu = FactoryBot.build(:menu, price: nil)
    menu.valid?
    expect(menu.errors[:price]).to include("can't be blank")
  end
  it 'is invalid with a duplicate name' do
    menu1 = FactoryBot.create(:menu, name: 'Nasi Goreng')
    menu2 = FactoryBot.build(:menu, name: 'Nasi Goreng')

    menu2.valid?

    expect(menu2.errors[:name]).to include('has already been taken')
  end
  it 'is invalid with a word has more than 150 chars' do
    menu = FactoryBot.build(:menu, name: Faker::String.random(length: 151))
    menu.valid?
    expect(menu.errors[:name]).to include('150 characters is the maximum allowed')
  end
  it 'is invalid with price less than 0.01' do
    menu = FactoryBot.build(:menu, price: 0.0)
    menu.valid?
    expect(menu.errors[:price]).to include("must be greater than or equal to 0.01")
  end
end
