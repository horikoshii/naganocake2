Rails.application.routes.draw do

  root to: "homes#top"
  get "/about",to: "homes#about"
  get "/admin", to: "admin/homes#top"

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :public do
    get "item/index" => "items#serch",as: "serch"
    get "customers/my_page" => "customers#show", as: "my_page"
    get "customers/unsubscribe" => "customers#unsubscribe"
    get "orders/comfirm" => "orders#comfirm"
    get "orders/complete" => "orders#complete"
    post "orders/complete" => "orders#complete"
    delete "cart_items/destroy_all" => "cart_items#destroy_all"
    patch "customers/withdraw" => "customers#withdraw"
    resources :items
    resources :addresses
    resources :cart_items,only: [:index,:create,:update,:destroy]
    resources :customers,only: [:show,:edit,:update,:unsubscribe,:withdraw]
    resources :genres
    resources :order_details
    resources :orders,only: [:new,:create,:index,:show,:comfirm,:complete]
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
