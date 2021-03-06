class FavoritesController < ApplicationController

  def index
    # current_user => ログイン中のユーザー Userモデル
    # favorite_topics => アソシエーション User => Favorite => Topicを取得
    # UserがFavoriteしたTopicを取得している
    @favorite_topics = current_user.favorite_topics
  end

  def create
    favorite = Favorite.new
    favorite.user_id = current_user.id
    # params[:topic_id]はlink_toタグのpath(topic_id: topic.id)から
    favorite.topic_id = params[:topic_id]

    if favorite.save
      redirect_to topics_path, success: 'お気に入りに登録しました'
    else
      redirect_to topics_path, danger: 'お気に入りに登録に失敗しました'
    end
  end

  def delete
    favorite = Favorite.find_by(
      user_id: current_user.id,
      topic_id: params[:topic_id]
    )
    if favorite.destroy
      redirect_to topics_path, success: 'お気に入り削除しました'
    else
      redirect_to topics_path, danger: 'お気に入り削除に失敗しました'
    end

  end
end
