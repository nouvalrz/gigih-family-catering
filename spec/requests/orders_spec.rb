require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
      let(:menu1) {FactoryBot.create(:menu)}
      let(:menu2) {FactoryBot.create(:menu)}
      it 'saves the new menu in the database' do
      expect{
        post '/api/v1/orders', params: {
          order: {
              customer_email: Faker::Internet.email,
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
              customer_email: ''
          }
        } 
        expect(json['errors'][0]['title']).to eq("Order must atleast have 1 menu")
      end
      it 'returns a unprocessable entity status' do
        post '/api/v1/orders', params: {
          order: {
              customer_email: ''
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
      let(:order_update) {FactoryBot.build(:order)}
      let(:menu1) {FactoryBot.create(:menu)}
      let(:menu2) {FactoryBot.create(:menu)}
      before do
        post '/api/v1/orders', params: {
          order: {
              customer_email: order_update.customer_email,
              menus: [
                {id: menu1.id, quantity: 12},
                {id: menu2.id, quantity: 12}
              ]
          }
        }
      end
      it 'update the selected menu in the database' do
        expect(json['data']['attributes']['customer_email']).to eq(order_update.customer_email)
      end
      it 'returns a status 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end
  describe 'DELETE /destroy' do
    context 'with exits records' do
      before do
        @order = FactoryBot.create(:order)
        @menu = FactoryBot.create(:menu)
        @order_details = OrderDetail.create(order_id: @order.id, menu_id: @menu.id)
      end
      it 'remove the order in database' do
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
  describe 'GET /show' do
    context "with exits order record" do
      before do
        @order = FactoryBot.create(:order)
      end
      it 'return the order according to the id' do
        get "/api/v1/orders/" + @order.id.to_s
        expect(json['data']).to have_type('order')
        expect(json['data']).to have_jsonapi_attributes(:customer_email)
      end
      it 'returns status code 200' do
        get "/api/v1/orders/" + @order.id.to_s
        expect(response).to have_http_status(:success)
      end
    end
    context "with non exits order record" do
      it 'returns status code 404' do
        get "/api/v1/orders/1298182989182981928919812" 
        expect(response).to have_http_status(404)
      end
    end 
  end
  describe 'PATCH /update_status' do
    before do
      @order = FactoryBot.create(:order)
    end
    context "with 'NEW', 'PAID', 'CANCELED'" do
      it 'return success when update to NEW' do
        patch "/api/v1/orders/#{@order.id}", params: {
          status: 'NEW'
        }
        expect(response).to have_http_status(:ok)
      end
      it 'return success when update to PAID' do
        patch "/api/v1/orders/#{@order.id}", params: {
          status: 'PAID'
        }
        expect(response).to have_http_status(:ok)
      end
      it 'return success when update to CANCELED' do
        patch "/api/v1/orders/#{@order.id}", params: {
          status: 'CANCELED'
        }
        expect(response).to have_http_status(:ok)
      end
    end
    context "without valid parameters" do
      it 'return error when update to invalid status' do
        patch "/api/v1/orders/#{@order.id}", params: {
          status: 'MISSING'
        }
        expect(response).to have_http_status(422)
      end
    end
  end
end