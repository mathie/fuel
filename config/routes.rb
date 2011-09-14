Fuel::Application.routes.draw do
  resources :fuel_prices, only: [ :index ] do
    collection do
      get :net_prices
    end
  end

  devise_for :users

  root to: 'pages#index'
end
