Rails.application.routes.draw do
 root  'tasks#index'
 post "login",to: 'sessions#create'
 delete "logout",to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 resources :tasks
 get "signup" ,to: "users#new"
 get "login" ,to: "sessions#new"
 resources :users , only: [:new,:create]
end
