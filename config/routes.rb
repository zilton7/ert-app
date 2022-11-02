Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :home, only: [:index]
  resources :tables, only: :index

  get :table, to: 'tables#show'
  get :search, controller: 'home'
end
