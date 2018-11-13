class SessionsController < ApplicationController
  def new
  end

  def create
    # user = User.find_by(email: params[:session][:email])
    # 課題 ストロングパラメータに書き換え #
    user = User.find_by(email: session_params[:email])
    # if user && user.authenticate(params[:session][:password])
    # 課題 ストロングパラメータに書き換え #
    if user && user.authenticate(session_params[:password])
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

  private
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

#######課題 ストロングパラメータ######
  def session_params
    params.require(:session).permit(:email, :password)
  end
#######課題 ストロングパラメータ######
end
