Rails.application.routes.draw do
  resources :listings
  resources :reservations
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  authenticated :user do
    root to: 'listings#index', as: :authenticated_root
  end

  root to: redirect('/users/sign_in')
end
