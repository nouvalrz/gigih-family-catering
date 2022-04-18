require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET /index' do
    context 'when category records exits' do
      before do
        FactoryBot.create_list(:category, 10)
        get '/api/v1/categories'
      end
      it 'returns all categories' do
        expect(json['data'].size).to eq(10)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
    context 'when category records empty' do
      it 'returns no data' do
        expect(response).to eq(nil)
      end
    end
  end
  describe "GET /show" do
    it "assigns the requested category to @category" do
      category = FactoryBot.create(:category)
      get "/api/v1/categories/#{category.id}"
      expect(assigns(:category)).to eq category
    end
  end
end