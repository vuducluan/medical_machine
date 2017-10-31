Rails.application.routes.draw do
  root "pages#home"
  resource :subcribers
  resources :products, only: [:show, :index]
  resources :medias, only: [:index]
  resources :contacts, only: [:index]
end
