Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  # 顧客側
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    resources :items, only:[:index, :show]
    resources :customers, only:[:show, :edit, :update] do
      collection do
        get 'withdraw'
        patch 'unsubscribe'
      end
    end
    resources :cart_items, only:[:index,:update,:create,:destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :orders, only:[:new, :create, :index, :show] do
      collection do
        post 'comfirm'
        get 'complete'
      end
    end
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  end

  scope module: :admin do
    get '/admin' => 'homes#top'
  end
end
