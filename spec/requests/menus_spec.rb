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
  describe 'POST /create' do
    context 'with valid menu and categories parameters' do
      let(:category1) {FactoryBot.create(:category)} 
      let(:category2) {FactoryBot.create(:category)} 
      let(:menu) {FactoryBot.build(:menu)}
      it 'saves the new menu in the database' do
      expect{
        post '/api/v1/menus', params: {
          menu: {
              name: menu.name,
              description: menu.description,
              price: menu.price,
              categories: [
                  {id: category1.id},
                  {id: category2.id}
              ]
          }
        } 
      }.to change(Menu, :count).by(1)
      end
      it 'returns a created status' do
        post '/api/v1/menus', params: {
          menu: {
              name: menu.name,
              description: menu.description,
              price: menu.price,
              categories: [
                  {id: category1.id},
                  {id: category2.id}
              ]
          }
        } 
        expect(response).to have_http_status(:created)
      end
    end
    context 'with valid parameters but already exits in database' do
      let(:category1) {FactoryBot.create(:category)} 
      let(:category2) {FactoryBot.create(:category)} 
      let(:menu) {FactoryBot.create(:menu)}
      before do
        post '/api/v1/menus', params: {
          menu: {
              name: menu.name,
              description: menu.description,
              price: menu.price,
              categories: [
                  {id: category1.id},
                  {id: category2.id}
              ]
          }
        } 
      end
      it 'returns error already been taken' do
        expect(json['errors'][0]['title']).to eq('Name has already been taken')
      end
      it 'return a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context 'with invalid parameter' do
      let(:menu) {FactoryBot.build(:menu, name: '')}
      before do
        post '/api/v1/menus', params: {
          menu: {
              name: menu.name,
              description: menu.description,
              price: menu.price
          }
        } 
      end
      it "returns error name can't be blank" do
        expect(json['errors'][0]['title']).to eq("Name can't be blank")
      end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it  'return error must have category' do
        expect(json['errors'][1]['title']).to eq("Menu must have atleast one category")
      end
    end
    context 'with non exits category' do
      let(:menu) {FactoryBot.build(:menu)}
      before do
        post '/api/v1/menus', params: {
          menu: {
            name: menu.name,
            description: menu.description,
            price: menu.price,
            categories: [
              {id: 1000}
            ]
          }
        } 
      end
      it 'return error category is not exits' do
        expect(json['errors'][0]['title']).to eq('Category with id : 1000 is not exits')
      end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  describe 'PUT /update' do
    context 'with valid parameters' do
      let(:menu) {FactoryBot.create(:menu)}
      let(:menu_update) {FactoryBot.build(:menu, name: 'Ayam Panggang')}
      let(:category_update) {FactoryBot.create(:category, name: 'Indonesia')}
      before do
        put "/api/v1/menus/#{menu.id}", params: {
          menu: {
            name: menu_update.name,
            description: menu_update.description,
            price: menu_update.price,
            categories: [
              {id: category_update.id}
            ]
          }
        } 
      end
      it 'update the selected menu in the database' do
        expect(json['data']['attributes']['name']).to eq(menu_update.name)
        expect(json['data']['attributes']['description']).to eq(menu_update.description)
        expect(json['data']['attributes']['price']).to eq(menu_update.price)
      end
      it 'update menu_categories from the selected menu' do
        expect(json['included'][0]['attributes']['name']).to eq(category_update.name)
      end
      it 'returns a status 200' do
        expect(response).to have_http_status(:success)
      end
    end
    context 'with invalid parameter' do
      let(:menu) {FactoryBot.create(:menu)}
      let(:category_update) {FactoryBot.create(:category, name: 'Indonesia')}
      before do
        put "/api/v1/menus/#{menu.id}", params: {
          menu: {
            name: nil,
            description: nil,
            price: nil,
            categories: [
              {id: category_update.id}
            ]
          }
        } 
      end
      it "returns error with nil in require attributes" do
        expect(json['errors'][0]['title']).to eq("Name can't be blank")
        expect(json['errors'][1]['title']).to eq("Price can't be blank")
      end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  describe 'DELETE /destroy' do
    context 'with exits records' do
      before :each do
        # @menu = FactoryBot.create(:menu)
        @menu_category = FactoryBot.create(:menu_category)
      end
      it 'remove the menu in database' do
        expect{ delete "/api/v1/menus/1" }.to change(Menu, :count).by(-1)
      end
      it 'remove the menu_categories in database' do
        expect{ delete "/api/v1/menus/1" }.to change(MenuCategory, :count).by(-1)
      end
      it 'returns status code 204' do
        delete "/api/v1/menus/1" 
        expect(response).to have_http_status(204)
      end
    end
    context 'with non exists records' do
      before do
        FactoryBot.create(:menu)
        delete '/api/v1/menus/121212'
      end
      it 'return a unprocessable entity status' do
        expect(response).to have_http_status(422)
      end
    end
  end
end