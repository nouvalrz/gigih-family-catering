require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
      let(:menu1) {FactoryBot.create(:menu)}
      let(:menu2) {FactoryBot.create(:menu)}
      it 'saves the new menu in the database' do
      expect{
        post '/api/v1/orders', params: {
          order: {
              customer_email: Faker::Internet.email,
              order_date: DateTime.now.strftime('%Y/%m/%d'),
              menus: [
                {id: menu1.id, quantity: 12},
                {id: menu2.id, quantity: 12}
              ]
          }
      } 
      }.to change(Order, :count).by(1)
      end
      it 'returns a created status' do
        category = FactoryBot.build(:category)
        post '/api/v1/categories', params: CategorySerializer.new(category).serializable_hash
        expect(response).to have_http_status(:created)
      end
    end
    context 'with invalid parameter' do
      let(:order_invalid_email) {FactoryBot.build(:order, email: 'halo@gigih')}
      let(:order_invalid_date) {FactoryBot.build(:order, email: 'halo@gigih')}
      let(:menu1) {FactoryBot.create(:menu)}
      let(:menu2) {FactoryBot.create(:menu)}
      it "returns error email can't be blank" do
        post '/api/v1/orders', params: {
          order: {
              customer_email: '',
              order_date: DateTime.now.strftime('%Y/%m/%d'),
              menus: [
                {id: menu1.id, quantity: 12},
                {id: menu2.id, quantity: 12}
              ]
          }
        } 
        expect(json['errors'][0]['title']).to eq("Customer email can't be blank")
      end
      it 'return error must have menu' do
        post '/api/v1/orders', params: {
          order: {
              customer_email: '',
              order_date: DateTime.now.strftime('%Y/%m/%d')
          }
        } 
        expect(json['errors'][0]['title']).to eq("Order must atleast have 1 menu")
      end
      it 'returns a unprocessable entity status' do
        post '/api/v1/orders', params: {
          order: {
              customer_email: '',
              order_date: DateTime.now.strftime('%Y/%m/%d')
          }
        } 
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context 'with non exits menu' do
      let(:order_invalid_email) {FactoryBot.build(:order, email: 'halo@gigih')}
      let(:order_invalid_date) {FactoryBot.build(:order, email: 'halo@gigih')}
      it 'return error menu is not exits' do
        post '/api/v1/orders', params: {
          order: {
              customer_email: 'nouvalr@gmail.com',
              order_date: DateTime.now.strftime('%Y/%m/%d'),
              menus: [
                {id: 1, quantity: 12},
                {id: 2, quantity: 12}
              ]
          }
        }
        expect(json['errors'][0]['title']).to eq('Menu with id: 1 is not exits')
      end
      it 'returns a unprocessable entity status' do
        post '/api/v1/orders', params: {
          order: {
              customer_email: 'nouvalr@gmail.com',
              order_date: DateTime.now.strftime('%Y/%m/%d'),
              menus: [
                {id: 1, quantity: 12},
                {id: 2, quantity: 12}
              ]
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  describe 'PUT /update' do
    context 'with valid parameters' do
      let(:order) {FactoryBot.create(:order)}
      let(:order_update) {FactoryBot.build(:order, order_date: DateTime.now.strftime('%Y/%m/%d'))}
      let(:menu1) {FactoryBot.create(:menu)}
      let(:menu2) {FactoryBot.create(:menu)}
      before do
        post '/api/v1/orders', params: {
          order: {
              customer_email: order_update.customer_email,
              order_date: order_update.order_date,
              menus: [
                {id: menu1.id, quantity: 12},
                {id: menu2.id, quantity: 12}
              ]
          }
        }
      end
      it 'update the selected menu in the database' do
        expect(json['data']['attributes']['customer_email']).to eq(order_update.customer_email)
        expect(json['data']['attributes']['order_date']).to eq(order_update.order_date.strftime("%F"))
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
        @order = FactoryBot.create(:order)
        @menu = FactoryBot.create(:menu)
        @order_details = FactoryBot.create(:order_detail, order_id: 1, menu_id: 1)
      end
      it 'remove the order in database' do
        puts "ERROR"
        puts Menu.first.inspect
        expect{ delete "/api/v1/orders/1" }.to change(Order, :count).by(-1)
      end
      it 'remove the menu_categories in database' do
        expect{ delete "/api/v1/orders/1" }.to change(OrderDetail, :count).by(-1)
      end
      it 'returns status code 204' do
        delete "/api/v1/orders/1" 
        expect(response).to have_http_status(204)
      end
    end
    context 'with non exists records' do
      before do
        FactoryBot.create(:menu)
        delete '/api/v1/orders/121212'
      end
      it 'return a unprocessable entity status' do
        expect(response).to have_http_status(422)
      end
    end
  end
end