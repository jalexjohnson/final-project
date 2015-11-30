Rails.application.routes.draw do

  root 'pages#home'

  resources :products

  get '/pages/:action', controller: 'pages'

  get '/auth/twitter/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
