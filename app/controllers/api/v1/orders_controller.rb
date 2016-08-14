require 'pry'
module Api
	module V1
		class OrdersController < ApplicationController

			def index
				@customer = User.find(params[:customer_id])
				@orders = @customer.orders
				render json: @orders
			end

			def show
				@customer = User.find(params[:customer_id])
				@order = @customer.orders.find(params[:id])
				render json: @order
			end

			def create
				@customer = User.find(params[:customer_id])
				@order = @customer.orders.create
				@order_item = @order.items.create(item_params)
				render json: @order_item
			end

			private

			def item_params
				params.require(:item).permit(:name)
			end
		end
	end
end

