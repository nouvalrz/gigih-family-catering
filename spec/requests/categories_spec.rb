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
          category = FactoryBot.build(:category)
          post '/api/v1/categories', params: CategorySerializer.new(category).serializable_hash
        }.to change(Category, :count).by(1)
      end
      it 'returns a created status' do
        category = FactoryBot.build(:category)
        post '/api/v1/categories', params: CategorySerializer.new(category).serializable_hash
        expect(response).to have_http_status(:created)
      end
    end
    context 'with valid parameters but already exits in database' do
      before do
        category1 = FactoryBot.create(:category, name: 'Javanese')
        category2 = FactoryBot.build(:category, name: 'Javanese')
        post '/api/v1/categories', params: CategorySerializer.new(category1).serializable_hash
        post '/api/v1/categories', params: CategorySerializer.new(category2).serializable_hash
      end
      it 'returns error already been taken' do
        expect(json['errors'][0]['title']).to eq('Name has already been taken')
      end
      it 'return a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context 'with invalid parameter' do
      before do
        category = FactoryBot.build(:category, name: '')
        post '/api/v1/categories', params: CategorySerializer.new(category).serializable_hash
      end
      it "returns error name can't be blank" do
        expect(json['errors'][0]['title']).to eq("Name can't be blank")
      end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  describe 'PUT /update' do
    context 'with valid parameters' do
      before do
        category = FactoryBot.create(:category)
        category_update = FactoryBot.build(:category, name: 'Dessert')
        put "/api/v1/categories/#{category.id}", params: CategorySerializer.new(category_update).serializable_hash
      end
      it 'update the selected category in the database' do
        category_update = FactoryBot.build(:category, name: 'Dessert')
        expect(json['data']['attributes']['name']).to eq(category_update.name)
      end
      it 'returns a status 200' do
        expect(response).to have_http_status(:success)
      end
    end
    context 'with valid parameters but already exits in database' do
      before do
        category1 = FactoryBot.create(:category, name: 'Dessert')
        category2 = FactoryBot.create(:category, name: 'Beverage')
        category_update = FactoryBot.build(:category, name: 'Dessert')
        put "/api/v1/categories/#{category2.id}", params: CategorySerializer.new(category_update).serializable_hash
      end
      it 'returns error already been taken' do
        expect(json['errors'][0]['title']).to eq('Name has already been taken')
      end
      it 'return a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context 'with invalid parameter' do
      before do
        category = FactoryBot.create(:category, name: 'Dessert')
        category_update = FactoryBot.build(:category, name: '')
        put "/api/v1/categories/#{category.id}", params: CategorySerializer.new(category_update).serializable_hash
      end
      it "returns error name can't be blank" do
        expect(json['errors'][0]['title']).to eq("Name can't be blank")
      end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  describe 'DELETE /destroy' do
    context 'with exits records' do
      before do
        category = FactoryBot.create(:category, name: 'Dessert')
        delete "/api/v1/categories/#{category.id}"
      end
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
    context 'with non exists records' do
      before do
        FactoryBot.create(:category, name: 'Dessert')
        delete '/api/v1/categories/12'
      end
      it 'return a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end