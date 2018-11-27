class SessionsController < ApplicationController
  def new
  end

  def create
    # フォームから送信されたメールアドレスを取得し一致するユーザー
    # がいるか検索。
    user = User.find_by(email: session_params[:email])
    # 該当のメールアドレスを持つuserがいる。かつ
    # userのパスワードが正しい場合true
    # authenticateメソッド => has_secure_passwordメソッドを有効にすると
    # 使えるようになる。authenticateメソッドは渡された引数を暗号化し
    # password_digestの値と一致するか判定してくれる
    if user && user.authenticate(session_params[:password])
      # 下でメソッドを定義。引数の()は省略されている
      log_in user
      redirect_to root_path, success: "ログインに成功しました"
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url, info: "ログアウトしました"
  end

  # sessionに代入された値はブラウザに保存される
  # sessionに値を代入するとそれ以降のアクセスでsessionの値を
  # Railsに送信する
  # 特定したユーザーのidを代入することでログインユーザーの情報を
  # 保持することができる
  private
  def log_in(user)
    session[:user_id] = user.id
  end

  # Railsに事前定義されているsessionをdeleteメソッドで削除
  # @current_userの中にログインしていたユーザー情報が残ったままになって
  # いる為current_userメソッドが使えるままになっている
  # なのでnilを代入してユーザー情報を削除する
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

# requireのキーである「:session」は
# view/sessions/new.html.erbのform_forのリソース名
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
