Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"

  # Limit possible actions on resources to index and show...
  resources :events, only: [:show, :index]
  resource :customer, only: [:show] do
    resources :orders, only: [:show, :index], shallow: true do
      resources :tickets, only: [:show, :index], shallow: true
    end
  end
  resource :shopping_cart, only: [:show]
  resources :ticket_types, only: [:show, :index]  

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :events do
        resources :ticket_types, shallow: true   
      end
      resources :ticket_types
    end
  end
  
end
