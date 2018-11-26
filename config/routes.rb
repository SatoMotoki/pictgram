Rails.application.routes.draw do
  get 'sessions/new'

  root 'pages#index'
  get 'pages/help'

  get     '/login',  to: 'sessions#new'
  post    '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :topics
  # resourcesで以下のルーティングが一括生成(topicsは省略)
  # ただしコントローラのアクションは設定する必要がある
  # GET users users#index
  # GET users/new users#new
  # POST users users#create
  # GET users/:id users#show
  # GET users/:id/edit users#edit
  # PATCH users/:id users#update
  # DELETE users/:id users#delete
  get 'favorites/index'
  post '/favorites', to: 'favorites#create'
end
