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
  describe 'GET /show' do
    it 'assigns the requested category to @category' do
      category = FactoryBot.create(:category)
      get "/api/v1/categories/#{category.id}"
      expect(assigns(:category)).to eq category
    end
  end
  describe 'POST /create' do
    context 'with valid parameters' do
      it 'saves the new category in the database' do
        expect{
          category = FactoryBot.create(:category)
          post '/api/v1/categories', params: CategorySerializer.new(category).serializable_hash
        }.to change(Category, :count).by(1)
      end
    end
    context 'with valid parameters but already exits in database' do
      before do
        category = FactoryBot.create(:category, name: 'Javanese')
        post '/api/v1/categories', params: CategorySerializer.new(category).serializable_hash
      end
      it 'returns error already been taken' do
        category = FactoryBot.build(:category, name: 'Javanese')
        post '/api/v1/categories', params: CategorySerializer.new(category).serializable_hash
        expect(json['errors'][0]['title']).to eq('Name has already been taken')
      end
    end
    context 'with invalid parameter' do
      before do
        category = FactoryBot.build(:category, name: '')
        post '/api/v1/categories', params: CategorySerializer.new(category).serializable_hash
      end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end