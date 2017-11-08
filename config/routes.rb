Rails.application.routes.draw do
  root "pages#home"
  resource :subcribers
  resources :products, only: [:show, :index] do
    member do
      get :order
      post :send_order
    end
  end
  resources :blogs, only: [:show, :index]
  resources :medias, only: [:show, :index]
  resources :contacts, only: [:index, :create]
  get "/products" => "products#index", as: :search_product

  namespace :admin do
    root "home#show"
    resources :home, only: [:show]
    devise_for :admins, :controllers => {:sessions => 'admin/sessions',
      :passwords => 'admin/passwords' }, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  end

end
