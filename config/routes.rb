Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			resource :menu do
				resources :items
			end
		end
	end
  #resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
