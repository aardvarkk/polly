Rails.application.routes.draw do
  resources :purchases, only: :index
  root to: 'spa#show'
end
