Rails.application.routes.draw do
  root "pages#home"
  resource :subcribers
  resources :products, only: [:show, :index]
  resources :medias, only: [:index]
  resources :blogs, only: [:show, :index]
  get "/products" => "products#index", as: :search_product
end
