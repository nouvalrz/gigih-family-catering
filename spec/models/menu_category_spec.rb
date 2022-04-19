require 'rails_helper'

RSpec.describe MenuCategory, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:menu_category)).to be_valid
  end

  it 'is invalid without a menu_id' do
    menu_category = FactoryBot.build(:menu_category, menu_id: nil)
    menu_category.valid?
    expect(menu_category.errors[:menu_id]).to include("can't be blank")
  end

  it 'is invalid without a category_id' do
    menu_category = FactoryBot.build(:menu_category, category_id: nil)
    menu_category.valid?
    expect(menu_category.errors[:category_id]).to include("can't be blank")
  end

  it 'is invalid add menu categories with same category' do
    menu_category1 = FactoryBot.create(:menu_category)
    menu_category2 = FactoryBot.build(:menu_category, menu_id: 1, category_id: 1)
    menu_category2.valid?
    expect(menu_category2.errors[:menu]).to include('Menu already has that category')
  end
end
