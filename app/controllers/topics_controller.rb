class TopicsController < ApplicationController
  def index
    @topics = Topic.all.includes(:favorite_users)
  end

  def new
    @topic = Topic.new
  end

  def create
    # current_user => ログイン中のユーザー Userモデル
    # Userモデルはhas_manyでtopicsと関連付けしている
    # 以下のコードはログイン中のユーザーのtopicの新しいインスタンスを作成している。詳しくは関連付けでググレ
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
