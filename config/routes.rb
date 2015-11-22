Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  scope '(:locale)', locale: /en|pl/ do
    get      '/login'   => 'session#new', as: :login
    post     '/login'   => 'session#create'
    delete   '/logout'  => 'session#destroy', as: :logout
    get      '/about'   => 'pages#about', as: :about

    resource  :profile
    get  '/profile/password_change' => 'profiles#change_password', as: :change_password
    post '/profile/password_change' => 'profiles#change_password_submit'

    resources :users
    get  '/users/:id/password_reset' => 'users#reset_password', as: :reset_user_password
    post '/users/:id/password_reset' => 'users#reset_password_submit'
  end

  get '/:locale' => 'pages#index'
  root to: 'pages#index'
end
