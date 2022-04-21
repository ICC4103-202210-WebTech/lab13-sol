Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#home"

  resources :events do
    resources :ticket_types, shallow: true
  end
  resources :ticket_types, only: [:show, :index]

  resource :customer, only: [:show] do
    resources :orders, only: [:show, :index], shallow: true do
      resources :tickets, only: [:show, :index], shallow: true
    end
  end

end
