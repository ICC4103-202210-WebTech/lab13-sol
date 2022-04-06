Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :ticket_types
    end
  end

  resources :ticket_types, defaults: { format: :html }  
end
