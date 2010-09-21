Superdevs::Application.routes.draw do |map|
  resources :examples

  resources :user_sessions
  resources :users
  resources :events
  resources :attendances
  map.follow_user 'users/:id/follow', :controller => 'users', :action => 'follow', :method => :put
  resources :password_resets
  map.activate '/activate/:activation_code', :controller => 'activations', :action => 'create'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.register 'register', :controller => 'users', :action => 'new'
  map.addrpxauth "addrpxauth", :controller => "users", :action => "addrpxauth", :method => :post
  map.complete_registration "complete_registration", :controller => "users", :action => "complete_registration", :method => :put
  map.edit_mandatory_details "edit_mandatory_details", :controller => "users", :action => "edit_mandatory_details", :method => :get

  map.invitation_requested 'invitation_requested', :controller => 'pages', :action => 'invitation_requested'
  map.privacy_policy 'privacy_policy', :controller => 'pages', :action => 'privacy_policy'
  map.terms_and_conditions 'terms_and_conditions', :controller => 'pages', :action => 'terms_and_conditions'
  map.contact_us 'contact_us', :controller => 'pages', :action => 'contact_us'

  get "home/index"
  get "pages/invitation_requested"

  root :to => "home#index"
end
