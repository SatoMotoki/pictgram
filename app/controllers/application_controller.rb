class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :denger
#######課題 ヘルパーにメソッド共有#########
  helper_method :current_user, :logged_in?
#######課題 ヘルパーにメソッド共有#########


  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
