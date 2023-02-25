Rails.application.routes.draw do
  get 'cart',to: 'cart#show'
  post 'cart/add'
  post 'cart/destroy'
  devise_for :users
  root 'home#index'
  resources :products do
    resources :comments
  end
end
