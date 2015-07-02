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

#@todo
#  users GET    /users(.:format)          users#index
#             POST   /users(.:format)          users#create
#  new_user GET    /users/new(.:format)      users#new
#  edit_user GET    /users/:id/edit(.:format) users#edit
#  user GET    /users/:id(.:format)      users#show
 # PATCH  /users/:id(.:format)      users#update
 # PUT    /users/:id(.:format)      users#update
 # DELETE /users/:id(.:format)      users#destroy

end
