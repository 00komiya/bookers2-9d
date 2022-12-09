Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'

  # 検索ボタンが押された時にsearchesコントローラーのsearchアクションが実行される
  get 'search' => 'searches#search'

  resources :users do
   resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
   resource :favorites, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end