require 'rails_helper'

RSpec.describe 'Orders', type: :request do
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
end