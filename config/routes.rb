Rails.application.routes.draw do
  resources :purchases, only: :index
  resources :sources, only: :index
  resources :codes, only: :index
  resources :departments, only: :index
  resources :vendors, only: :index
  resources :contract_styles, only: :index
  resources :locations, only: :index
  root to: 'spa#show'
end
