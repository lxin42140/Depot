Rails.application.routes.draw do
  resources :carts
  devise_for :users
  root to: "products#index"
  # match '*path' => redirect("products#index"), via: [:get]

  # get '/sale_transactions',
  #     to: 'sale_transactions#index',
  #     constraints: ->(request){  User.current_user.present? && User.current_user.access_right_enum == 1}
  
  #resources
  resources :users
  resources :sale_transactions
  resources :sale_transaction_line_items
  resources :products
end
