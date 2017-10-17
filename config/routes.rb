Rails.application.routes.draw do
  root "pages#home"
  resource :subcribers
end
