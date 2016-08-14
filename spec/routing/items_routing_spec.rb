require "rails_helper"

module Api
	module V1
		RSpec.describe ItemsController, type: :routing do
			describe "routing" do
				it "routes to #index" do
					pending 'Not yet implemented'
					expect(:get => "/items").to route_to("items#index")
				end

				it "routes to #new" do
					pending 'Not yet implemented'
					expect(:get => "/items/new").to route_to("items#new")
				end

				it "routes to #show" do
					pending 'Not yet implemented'
					expect(:get => "/items/1").to route_to("items#show", :id => "1")
				end

				it "routes to #edit" do
					pending 'Not yet implemented'
					expect(:get => "/items/1/edit").to route_to("items#edit", :id => "1")
				end

				it "routes to #create" do
					pending 'Not yet implemented'
					expect(:post => "/items").to route_to("items#create")
				end

				it "routes to #update via PUT" do
					pending 'Not yet implemented'
					expect(:put => "/items/1").to route_to("items#update", :id => "1")
				end

				it "routes to #update via PATCH" do
					pending 'Not yet implemented'
					expect(:patch => "/items/1").to route_to("items#update", :id => "1")
				end

				it "routes to #destroy" do
					pending 'Not yet implemented'
					expect(:delete => "/items/1").to route_to("items#destroy", :id => "1")
				end

			end
		end
	end
end