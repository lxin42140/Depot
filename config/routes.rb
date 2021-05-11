Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  match '*path' => redirect('/'), via: :get

  #resources
  resources :users
  resources :sale_transactions
  resources :sale_transaction_line_items
  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
