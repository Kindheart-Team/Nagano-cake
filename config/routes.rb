Rails.application.routes.draw do

  namespace :admin do
    root to: 'homes#top'
    resources :genres, only: [:new, :create, :index, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :edit, :update]
  end




  scope module: 'public' do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'

    #customers [show.edit.update.unsubscribe.withdraw]
    get 'customers/my_page' => 'customers#show', as: 'my_page'
    get 'customers/infomation/edit' => 'customers#edit', as: 'my_page_edit'
    patch 'customers/infomation' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]

    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'

    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/check' => 'orders#check', as: 'check'
    get 'orders/complete' => 'orders#complete', as: 'complete'
  end



  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
end
