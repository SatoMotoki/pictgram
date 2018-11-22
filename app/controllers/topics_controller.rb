class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    # current_userはapplication_controllerで作成。ログイン中のユーザー
    # しかし、その直後のtopics.newが分からない
    # 新しいインスタンスの作成？なぜ複数形？
    # そもそもメソッドの後にモデル(複数形).newメソッドというのを初見
    # メンターに確認
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      # topics_path => GET /topics topics#index
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  # ストロングパラメータの基本的な使い方
  # ①requireでPOSTで受け取る値のキーを設定
  # ②permitで許可するカラムを設定
  private
  def topic_params
    params.require(:topic).permit(:image, :description)
  end
end
