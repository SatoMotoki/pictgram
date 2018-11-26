class ApplicationController < ActionController::Base
  # CSRF対策。デフォルト。
  protect_from_forgery with: :exception
  # フラッシュタイプの指定
  # 使い方 add_flash_types :タイプ名
  # controller redirect_to xxx, タイプ名: "メッセージ"
  add_flash_types :success, :info, :warning, :danger
  helper_method :current_user, :logged_in?


  def current_user
    # 「||=」は左の値がnilはまたはfalseなら右の値を代入する
    # session[user_id]はログイン中のユーザーid
    # find_byメソッドを用いてUserテーブルからidカラム
    # の値がsession[:user_id]と等しいユーザーを取得し、変数に代入
    # 「=」を使うと毎回dbにアクセスしてしまう(負荷増)
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ログインしているかどうかを確認するためのメソッド
  def logged_in?
    # !演算子は真偽値を反転させる
    # ?で終わるメソッドは慣習的に真偽値を返すメソッド
    # 本来であればあればnilならtrue。nilでなければfalseとなる
    # しかし!演算子で始まっているため反転される
    # つまりcurrent_userがnilならfalse。nilでなければtrueが返される
    !current_user.nil?
  end
end
