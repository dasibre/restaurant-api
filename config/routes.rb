Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			concern :itemable do
				resources :items
			end
			resource :menu, concerns: [:itemable]
			resources :customers do
				resources :orders, concerns: [:itemable]
			end
		end
	end
end
