Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root     'pages#index'
  get      '/login'  => 'session#new', as: :login
  post     '/login'  => 'session#create'
  delete   '/logout' => 'session#destroy', as: :logout
  get      '/about'  => 'pages#about', as: :about

  resource  :profile
  resources :users
end
