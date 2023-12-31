Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # ゲストログインルーティング
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  # 管理者側ルーティング
  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :update] do
      resources :comments, only: [:index, :destroy]
      member do
        patch :active
      end
    end
  end

  # ユーザー側ルーティング
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    get 'posts/search' => "posts#search"
    get 'search_tag' => "posts#search_tag"
    get 'search_title' => "posts#search_title"
    resources :posts do
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only:[:index, :show, :edit, :update] do
      resources :favorites, only: [:index]
      collection do
        get :confirm
        patch :withdrawal
      end
    end
  end
end