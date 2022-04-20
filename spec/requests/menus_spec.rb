require 'rails_helper'

RSpec.describe 'Menus', type: :request do
  describe 'GET /index' do
    context 'when menus records exits' do
      before do
        FactoryBot.create_list(:menu_category, 10)
        get '/api/v1/menus'
      end
      it 'returns all menus and all categories relationship' do
        expect(json['data'].size).to eq(10)
        expect(json['included'][0]).to have_type(:category)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
    context 'when menus records empty' do
      it 'returns no data' do
        expect(response).to eq(nil)
      end
    end
  end
  describe 'GET /show' do
    it 'assigns the requested menu and category relationships to @menu' do
      menu_categories = FactoryBot.create(:menu_category)
      menu = Menu.first
      get "/api/v1/menus/#{menu.id}"
      expect(assigns(:menu)).to eq menu
      expect(json['included'][0]).to have_type(:category)
    end
  end
end