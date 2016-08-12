require 'rails_helper'
require 'pry'

RSpec.describe 'Items', type: :request do
	describe 'GET /api/v1/items' do
		it 'responds with 200 success code' do
			get '/api/v1/items'
			expect(response).to have_http_status(200)
		end

		it 'returns all items' do
			%w(chicken rice).each {|item_name| create(:item, name: item_name)}
			get '/api/v1/items'
			item_names = JSON.parse(response.body).map {|item| item['name']}
			expect(item_names).to eq(['chicken', 'rice'])
		end
	end

	describe 'GET /api/v1/items/:id' do
		context 'when item is not found' do
			it 'responds with 404 error' do
				get '/api/v1/items/1'
				expect(response).to have_http_status(404)
			end
		end

		context 'when item is found' do
			let(:item) { create(:item) }

			it 'responds with 200 success code' do
				get "/api/v1/items/#{item.id}"
				expect(response).to have_http_status(200)
			end

			it 'returns item for given :id' do
				get "/api/v1/items/#{item.id}"
				item_id = JSON.parse(response.body)['id']
				expect(item_id).to eq(item.id)
			end
		end
	end
end
