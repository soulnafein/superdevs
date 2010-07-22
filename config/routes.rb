Superdevs::Application.routes.draw do |map|
  map.activate '/activate/:activation_code', :controller => 'activations', :action => 'create'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.register 'register', :controller => 'users', :action => 'new' 
  resources :user_sessions
  resources :users
  resources :password_resets

  map.invitation_requested 'invitation_requested', :controller => 'pages', :action => 'invitation_requested'
  map.privacy_policy 'privacy_policy', :controller => 'pages', :action => 'privacy_policy'
  map.terms_and_conditions 'terms_and_conditions', :controller => 'pages', :action => 'terms_and_conditions'

  get "home/index"
  get "pages/invitation_requested"

  root :to => "home#index"
end
