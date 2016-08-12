require 'rails_helper'

module Api
	module V1
		RSpec.describe ItemsController, type: :controller do
			describe '#index' do
				let(:item) { create(:item) }

				it 'responds with 200 status' do
					get :index
					expect(response).to have_http_status(:success)
				end
			end
		end
	end
end
