require 'rails_helper'

RSpec.describe 'Reports', type: :request do
  describe 'GET /reports' do
    context 'without any query params' do
      before do
        order_today = FactoryBot.create_list(:order, 10, created_at: Date.today)
        order_past = FactoryBot.create_list(:order, 10, created_at: Date.new(1945,11,17))
        get '/api/v1/reports'
      end
      it 'returns all order' do
        expect(json['data'].size).to eq(10)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
    context 'with all query params' do
      before do
        correct_order = FactoryBot.create(:order, total_price: 1.0, customer_email: 'nouvalr@gmail.com')
        wrong_order = FactoryBot.create(:order, total_price: 200000000)
        get "/api/v1/reports?customer_email=nouvalr@gmail.com&start_price=0&end_price=10"
      end
      it 'returns no data' do
        expect(json['data'].size).to eq(1)
      end
    end  
  end
end