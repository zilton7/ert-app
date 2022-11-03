Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tables#search'

  resources :home, only: [:index]
  resources :tables, only: [:index, :show]

  # get :table, to: 'tables#show'
  get :search, controller: 'tables'
  get :build, controller: :tables
end
