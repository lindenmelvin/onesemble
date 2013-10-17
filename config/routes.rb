Onesemble::Application.routes.draw do
  
  devise_for :users
  
  devise_scope :user do
    get "login", :to => "devise/sessions#new"
    get "logout", :to => "devise/sessions#destroy"
    get "signup", :to => "devise/registrations#new"
    root :to => 'devise/sessions#new'
  end
  
  resources :posts do
    post :search, :on => :collection
  end
  
  resources :messages
  
  resources :users
  
  resources :requests
  resources :recommendations
  resources :ratings
  
  match '/profile' => 'users#profile'
end
