Rails.application.routes.draw do

  root to: "homes#top"
  get "/admin", to: "admin/homes#top"

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :customer do
    resources :items
    resources :addresses
    resources :cart_items
    resources :customers
    resources :genres
    resources :order_details
    resources :orders
  end

  namespace :admin do
    resources :items
    resources :addresses
    resources :cart_items
    resources :customers
    resources :genres
    resources :order_details
    resources :orders
  end
end
