Rails.application.routes.draw do
  get "splash", to: "splash#index"
  resources :purchases, only: :index do
  	collection do
  		get :fiscal_years
  	end
  end
  resources :sources, only: :index
  resources :codes, only: :index
  resources :departments, only: :index
  resources :vendors, only: :index
  resources :contract_styles, only: :index
  resources :locations, only: :index
  resources :categories, only: :index
  root to: 'spa#show'
end
