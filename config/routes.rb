Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			delete 'users/:user_id/items/:id' => 'items#destroy'
			post 'users/:user_id/items/' => 'items#create'
			put 'users/:user_id/items/:id' => 'items#update'
			concern :itemable do
				resources :items, only: [:index, :show]
			end

			resource :menu, concerns: [:itemable]
			resources :customers do
				resources :orders, concerns: [:itemable]
			end
		end
	end
end
