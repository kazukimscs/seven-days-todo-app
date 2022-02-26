Rails.application.routes.draw do
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root 'top#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

=begin
  get 'homes', to: 'homes#index'#RESTFULLで記述している。GETメソッドでパス/homesにリクエストがくるとHomesController
  #のindexメソッド(アクション)が呼び出される。
  get 'homes/new', to: 'homes#new'
  get 'homes/show', to: 'homes#show'
  post 'homes/new', to: 'homes#create'
  get 'homes/show/:id', to: 'homes#edit'
=end

#delete 'homes/:id', to: 'homes#destroy'
#リソースベースルーティング
  resources :users, only: %i[new create] #シンボルの配列を表す%記法で書いただけ。
  resources :homes, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :homes do
    collection do
      get 'sevendays'
    end
  end
end