Rails.application.routes.draw do
  devise_for :customers
  devise_for :admin
  # 顧客側
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    resources :items, only:[:index, :show]
    resources :customers, only:[:show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    resources :cart_items, only:[:index,:update,:create,:destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :orders, only:[:new, :create, :index, :show] do
      collection do
        get 'comfirm'
        get 'complete'
      end
    end
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    get '/' => 'homes#top'
    get "search" => "searches#search"
    resources :customers, only:[:index]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, only:[:index, :new, :create, :show]
    resources :orders, only:[:index, :show, :update]
    resources :order_posts, only:[:update]
  end
end
