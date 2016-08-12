require 'pry'
module Api
	module V1
		class ItemsController < ApplicationController
			before_action :set_item, only: [:show, :update, :destroy]

			def index
				@items = Item.all
				render json: @items
			end

			def show
				render json: @item
			end

			def create
				@item = Item.new(item_params)
				if @item.save
					render json: @item, status: :created
				else
					render json: @item.errors, status: :unprocessable_entity
				end
			end

			# PATCH/PUT /items/1
			def update
				if @item.update(item_params)
					render json: @item
				else
					render json: @item.errors, status: :unprocessable_entity
				end
			end

			# DELETE /items/1
			def destroy
				@item.destroy
			end

			private

			def set_item
				@item = Item.find(params[:id])
			rescue ActiveRecord::RecordNotFound => e
				return render json: { error: { status: 404, message: 'item not found' }}, status: :not_found
			end

			def item_params
				params.require(:item).permit(:name)
			end
		end
	end
end

