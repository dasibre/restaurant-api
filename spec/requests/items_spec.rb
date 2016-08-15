require 'rails_helper'

RSpec.describe 'Items', type: :request do

	def json_parse(json)
		JSON.parse(json)
	end

	def end_point
		'/api/v1/menu/items'
	end

	describe 'DELETE /api/v1/users/:id/items/:id' do
		context 'when user not admin' do
			it 'returns unauthorized status' do
				create(:item)
				create(:user)
				delete '/api/v1/users/1/items/1', params: { item: { id: 1} }
				expect(response).to have_http_status(401)
			end
		end

		it 'deletes the specified item' do
			create(:item, name: 'Hamburger')
			create(:user, admin: true)
			delete '/api/v1/users/1/items/1', params: { user_id: 1 }
			expect(response).to have_http_status(204)
		end
	end

	describe 'PUT /api/v1/users/:id/items/:id' do
		it 'updates the specified item' do
			create(:item)
			create(:user, admin: true)
			params = { item: { name: 'Whopper' } }
			put '/api/v1/users/1/items/1', params: params
			body = json_parse(response.body)
			expect(body['name']).to eq('Whopper')
		end
	end

	describe 'POST /api/v1/users/:id/items' do
		it 'creates the specified item' do
			create(:user, admin: true)
			params = { user_id: 1, item: { name: 'Fried Rice' } }
			post '/api/v1/users/1/items', params: params
			expect(response).to have_http_status(201)
		end

		it 'returns created item' do
			create(:user, admin: true)
			params = { item: { name: 'Fried Rice'} }
			post '/api/v1/users/1/items', params: params
			body = json_parse(response.body)
			expect(body['name']).to eq('Fried Rice')
		end
	end

	describe 'GET Items /endpoint/' do
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

	describe 'GET item /endpoint/:id' do
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
