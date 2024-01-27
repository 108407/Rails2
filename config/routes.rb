Rails.application.routes.draw do
  resources :comments
  get 'reservations/index'
  post 'reservations/confirm', to: 'reservations#confirm'
  get 'rooms/index'
  get 'rooms/own', to: 'rooms#own'
  get 'users/account', to: 'users#account'
  get 'users/profile', to: 'users#profile'
  get 'top/index'
  
  devise_for :users
  root "top#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :reservations do
    collection {get "confirm"}
  end
  resources :rooms do
    collection do
      get 'search'
    end
  end
  resources :rooms
  resources :rooms do
    resources :reservations
  end
end
