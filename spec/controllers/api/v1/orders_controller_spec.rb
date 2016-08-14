require 'rails_helper'

module Api
	module V1
		RSpec.describe OrdersController, type: :controller do

			before do
				create(:order)
			end

			describe 'GET #index' do
				it 'returns http success' do
					get :index, params: {customer_id: 1, order_id: 1}
					expect(response).to have_http_status(:success)
				end
			end

			describe 'GET #show' do
				it 'returns http success' do
					get :show, params: { customer_id: 1 , id: 1}
					expect(response).to have_http_status(:success)
				end
			end

			describe 'GET #create' do
				it 'returns http success' do
					get :create, params: { customer_id: 1, item: { name: 'Soup'} }
					expect(response).to have_http_status(:success)
				end
			end

		end
	end
end

