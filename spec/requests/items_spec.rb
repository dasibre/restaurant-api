require 'rails_helper'
require 'pry'
RSpec.describe 'Items', type: :request do

	def json_parse(json)
		JSON.parse(json)
	end

	def end_point
		'/api/v1/menu/items'
	end

	def api_post(params)
		post end_point, params: params
	end

	describe 'DELETE /endpoint/:id' do
		it 'deletes the specified item' do
			create(:item, name: 'Hamburger')
			delete "#{end_point}/1"
			expect(response).to have_http_status(204)
		end
	end

	describe 'PUT /endpoint/:id' do
		it 'updates the specified item' do
			create(:item)
			params = { item: { name: 'Whopper' } }
			put "#{end_point}/1", params: params
			body = json_parse(response.body)
			expect(body['name']).to eq('Whopper')
		end
	end

	describe 'POST /api/v1/items' do
		it 'creates the specified item' do
			params = { item: { name: 'Fried Rice' } }
			api_post(params)
			expect(response).to have_http_status(201)
		end

		it 'returns created item' do
			params = { item: { name: 'Fried Rice'} }
			api_post(params)
			body = json_parse(response.body)
			expect(body['name']).to eq('Fried Rice')
		end
	end

	describe 'GET Items /api/v1/items' do
		it 'responds with 200 success code' do
			get end_point
			expect(response).to have_http_status(200)
		end

		it 'returns all items' do
			%w(chicken rice).each {|item_name| create(:item, name: item_name)}
			get end_point
			item_names = json_parse(response.body).map {|item| item['name']}
			expect(item_names).to eq(['chicken', 'rice'])
		end
	end

	describe 'GET item /api/v1/items/:id' do
		context 'when item is not found' do
			it 'responds with 404 error' do
				get "#{end_point}/1"
				expect(response).to have_http_status(404)
			end

			it 'returns item not found response message' do
				get "#{end_point}/1"
				body = json_parse(response.body)
				message = body['error']['message']
				expect(message).to eq('item not found')
			end
		end

		context 'when item is found' do

			before do
				create(:item)
			end

			it 'responds with 200 success code' do
				get "#{end_point}/1"
				expect(response).to have_http_status(200)
			end

			it 'returns item for given :id' do
				get "#{end_point}/1"
				item_id = json_parse(response.body)['id']
				expect(item_id).to eq(1)
			end
		end
	end
end
