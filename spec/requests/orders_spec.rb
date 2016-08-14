require 'rails_helper'


#I need to create a new order
#i need to send a post to order_controller#create with item_id
#might need customer id
#api/v1/orders/:customer_id/:item_id
#
# def create
# 	order = Order.new
#
# end

RSpec.describe 'Orders', type: :request do
	describe 'GET Orders /api/v1/customers/:id/orders' do
		it 'responds with 200 status' do
			get '/api/v1/customers/1/orders'
			expect(response).to have_http_status(200)
		end
	end
end