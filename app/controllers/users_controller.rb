class UsersController < ApplicationController
  def new
    @user = User.new
  end

  # views/users/new.html.erbより
  # フォームが入力され送信されたらcreateアクションへ送信される
  # (user_params)は下で定義している
  def create
    @user = User.new(user_params)
    if @user.save
      # root_path => GET / pages#index
      # ApplicationControllerでadd_flash_typeでフラッシュの指定をしているため、タイプ名: "メッセージ" でフラッシュが使える
      redirect_to root_path, success: "登録が完了しました"
    else
      # renderを用いてフラッシュを表示する場合は
      # flash.now[:notice]で設定
      # :dangerはApplicationControllerのadd_flash_typeで指定
      flash.now[:danger] = "登録に失敗しました"
      # render => アクションを経由しないでviewを呼び出す
      # オプションは省略可能。。。？
      render :new
    end
  end

  # privateメソッドはclassの外部から呼び出せない
  private
  # 悪意のある不正なデータから防ぐ為ストロングパラメータを実装
  # ストロングパラメータの基本的な使い方
  # ①requireでPOSTで受け取る値のキーを設定
  # ②permitで許可するカラムを設定
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
