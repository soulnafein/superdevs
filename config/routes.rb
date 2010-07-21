Superdevs::Application.routes.draw do |map|
  map.activate '/activate/:activation_code', :controller => 'activations', :action => 'create'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.register 'register', :controller => 'users', :action => 'new' 
  resources :user_sessions
  resources :users
  resources :password_resets

  get "home/index"
  get "pages/invitation_requested"

  root :to => "home#index"
end
