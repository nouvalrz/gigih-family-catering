require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:category, 10)
      get '/api/v1/categories'
    end
    it 'returns all categories' do
      expect(json['data'].size).to eq(10)
    end
  end
end