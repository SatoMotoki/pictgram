class UsersController < ApplicationController
  def new
    @user = User.new
  end

  # views/users/new.html.erbより
  # nameやemail等のフォームが入力され送信されたら
  # createアクションへ送信される。そして、それぞれのフォームの値が
  # paramsへ格納され、それを元にデータを作成する
  def create
    @user = User.new(user_params)
    if @user.save
      # root_path => GET / pages#index
      # ApplicationControllerでadd_flash_typeでフラッシュの指定をしてるため、タイプ名: "メッセージ" でフラッシュが使える。
      redirect_to root_path, success: "登録が完了しました"
    else
      # renderを用いてフラッシュを表示する場合は
      # flash.now[:notice]で設定する。
      # :dangerはApplicationControllerのadd_flash_typeで指定している。
      flash.now[:danger] = "登録に失敗しました"
      # render => アクションを経由しないでviewを呼び出す
      # 文字列もしくはシンボルで呼び出せるのだけどアクション
      # オプションは省略可能なのか？＊＊調べても分からない＊＊
      render :new
    end
  end

  # 悪意のある不正なデータから防ぐ為ストロングパラメータを実装
  # privateメソッドはclassの外部から呼び出せない
  # ストロングパラメータの基本的な使い方
  # ①requireでPOSTで受け取る値のキーを設定
  # ②permitで許可するカラムを設定
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
