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
    # context 'with non exits category' do
    #   let(:menu) {FactoryBot.build(:menu)}
    #   before do
    #     post '/api/v1/menus', params: {
    #       menu: {
    #         name: menu.name,
    #         description: menu.description,
    #         menus: [
    #           {id: menu1.id, quantity: 12},
    #           {id: menu2.id, quantity: 12}
    #         ]
    #       }
    #     } 
    #   end
    #   it 'return error category is not exits' do
    #     expect(json['errors'][0]['title']).to eq('Category with id : 1000 is not exits')
    #   end
    #   it 'returns a unprocessable entity status' do
    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end
    # end
  end
end