Rails.application.routes.draw do
  resources :users, :posts
  resources :home, only: [:index] do
    member do
        put 'like' => 'home#like'
        put "unlike" => "home#unlike"
        put "dislike" => "home#dislike"
        put "undislike" => "home#undislike"
    end
  end
  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'

  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create', as: 'log_in'
  delete 'logout', to: 'sessions#destroy'

  get 'password', to: 'passwords#edit', as: 'edit_password'
  patch 'password', to: 'passwords#update'

  root 'home#index'
end
