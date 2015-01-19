Rails.application.routes.draw do
  root to: 'home#show'

  resources :photos, only: [:index]
  resources :products, only: [:index]
  resources :comments, only: [:index, :create]
end
