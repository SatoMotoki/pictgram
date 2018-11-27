Rails.application.routes.draw do
  get 'sessions/new'

  root 'pages#index'
  get 'pages/help'

  get     '/login',  to: 'sessions#new'
  post    '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # resourcesで以下のルーティングが一括生成(topicsは省略)
  # ただしコントローラのアクションは設定する必要がある
  # GET users users#index
  # GET users/new users#new
  # POST users users#create
  # GET users/:id users#show
  # GET users/:id/edit users#edit
  # PATCH users/:id users#update
  # DELETE users/:id users#delete
  resources :users

  # resourcesで7つのルーティングを一括生成
  # 加えてネスト(入れ子構造)のcommentsのルーティングも作成
  # new_topic_comment GET /topics/:topic_id/comments/new comments#new
  # topic_comments POST /topics/:topic_id/comments comments#create
  resources :topics do
    resources :comments, only: [:new, :create]
  end

  get 'favorites/index'
  post '/favorites', to: 'favorites#create'
  delete '/favorites', to: 'favorites#delete'

end
