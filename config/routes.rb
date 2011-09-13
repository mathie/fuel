Fuel::Application.routes.draw do
  resources :fuel_prices, only: [ :index ]

  devise_for :users

  root to: 'pages#index'
end
