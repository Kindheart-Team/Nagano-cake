Rails.application.routes.draw do

  namespace :admin do
    get '/index'
    get 'books/show'
    get 'books/edit'
    
    
    root to: 'homes#top'
    resources :genres, only: [:new, :reate, :index, :edit, :update]
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
