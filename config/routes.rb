Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 管理者側ルーティング
  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:update] do
      resource :comments, only: [:index, :destroy]
    end
  end

  # ユーザー側ルーティング
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    resources :posts do
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only:[:show, :edit] do
      collection do
        get :confirm
        patch :withdrawal
      end
    end
  end
end
