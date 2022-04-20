require 'rails_helper'

RSpec.describe MenuCategory, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:menu_category)).to be_valid
  end

  it 'is invalid add menu categories with same category' do
    menu_category1 = FactoryBot.create(:menu_category)
    menu_category2 = FactoryBot.build(:menu_category, menu_id: 1, category_id: 1)
    menu_category2.valid?
    expect(menu_category2.errors[:menu]).to include('already has that category')
  end
end
