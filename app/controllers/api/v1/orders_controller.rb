module Api
	module V1
		class OrdersController < ApplicationController

			def index
				@customer = User.find(params[:customer_id])
				@orders = @customer.orders
				render json: @orders
			end

			def show
			end

			def create
			end
		end
	end
end

