Rails.application.routes.draw do
  root "pages#home"
  resource :subcribers
  resources :products, only: [:show, :index]
  resources :blogs, only: [:show, :index]
  resources :medias, only: [:show, :index]
  resources :contacts, only: [:index, :create]
  get "/products" => "products#index", as: :search_product
end
