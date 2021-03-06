Superdevs::Application.routes.draw do

  resources :user_sessions,:users, :events, :attendances, :posts,
            :links, :code_snippets, :password_resets, :memberships,
            :comments

  resources :users do
    member do
      get 'edit_accounts'
    end
  end

  resources :groups do
    resources :events
  end

  resources :events do
    resources :attendances
    member do
      get 'attend'
      get 'unattend'
      get 'track'
      get 'untrack'
      get 'attendances'
      get 'login'
      get 'icalendar'
      get 'deactivate'
    end
  end

  match 'users/:id/follow', :to => 'users#follow', :as => 'follow_user',
          :via  => :put

  controller :user_sessions do
    match '/login', :to => :new, :as => 'login'
    match '/logout', :to => :destroy, :as => 'logout'
  end

  controller :users do
    match 'addrpxauth', :to => :addrpxauth, :as => 'addrpxauth', :via => :post
    match 'complete_registration', :to => :complete_registration, :via => :put
    match 'edit_mandatory_details', :to => :edit_mandatory_details
  end

  controller :pages do
    match 'invitation_requested', :to => :invitation_requested
    match 'privacy_policy', :to => :privacy_policy
    match 'terms_and_conditions', :to => :terms_and_conditions
    match 'contact_us', :to => :contact_us
  end

  get "home/index"

  root :to => "home#index"
end
