require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:category, 10)
      get '/api/v1/categories'
    end
    
    it 'returns all posts' do
      expect(json.size).to eq(10)
    end

    # it 'returns status code 200' do
    #   expect(response).to have_http_status(:success)
    # end
  end
end