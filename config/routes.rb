Rails.application.routes.draw do
  namespace :admin do
    get 'comments/index'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/confirm'
  end
  devise_for :user,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
