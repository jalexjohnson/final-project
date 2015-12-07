Rails.application.routes.draw do

  root 'pages#home'

  get '/api/products' => 'products#show_count'
  post '/api/products' => 'products#ship'

  resources :products

  get '/pages/:action', controller: 'pages'

  get '/auth/twitter/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
