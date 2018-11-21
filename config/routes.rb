Rails.application.routes.draw do
  get 'sessions/new'

  root 'pages#index'
  get 'pages/help'

  resources :users
  # resourcesで以下のルーティングが一括生成
  # ただしコントローラのアクションは自分で定義する必要あり
  # GET users users#index
  # GET users/new users#new
  # POST users users#create
  # GET users/:id users#show
  # GET users/:id/edit users#edit
  # PATCH users/:id users#update
  # DELETE users/:id users#delete

  get     '/login',  to: 'sessions#new'
  post    '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
