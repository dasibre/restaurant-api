require 'rails_helper'

RSpec.describe 'Orders', type: :request do

	describe 'POST Orders /api/v1/customers/:id/orders' do
		let(:params) {
			{
					item: { name: 'Whopper' },
					user: { user_id: 1 }
			}
		}

		before do
			create(:user)
			post '/api/v1/customers/1/orders/', params: params
		end

		it 'responds with 200 status' do
			expect(response).to have_http_status(200)
		end

		it 'returns item added to order' do
			body = JSON.parse(response.body)
			expect(body['name']).to eq('Whopper')
		end
	end

	describe 'GET Orders /api/v1/customers/:id/orders' do
		it 'responds with 200 status' do
			create(:user)
			get '/api/v1/customers/1/orders'
			expect(response).to have_http_status(200)
		end

		it 'returns orders for specified customer' do
			user_one = create(:user, email: 'user@foo.com')
			user_two = create(:user, email: 'user2@foo.com')
			user_one.orders.create!
			user_two.orders.create

			get '/api/v1/customers/1/orders'

			body = JSON.parse(response.body)[0]

			expect(body['id']).to eq(1)
			expect(body['user_id']).to eq(1)
		end
	end

	describe 'GET Order /api/v1/customers/:id/orders/:id' do
		it 'responds with 200 status' do
			create(:order)
			get '/api/v1/customers/1/orders/1'
			expect(response).to have_http_status(200)
		end
	end
end