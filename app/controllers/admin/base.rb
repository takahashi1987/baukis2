class Admin::Base < ApplicationController
  helper_method :current_administrator
  before_action :authorize, :check_account, :check_timeout

  private

  def current_administrator
    if session[:administrator_id]
      @current_administrator ||= Administrator.find(session[:administrator_id])
    end
  end

  def authorize
    unless current_administrator
      flash.alert = "管理者としてログインしてください。"
      redirect_to :admin_login
    end
  end

  def check_account
    if current_administrator && current_administrator.suspended?
      session.delete(:administrator_id)
      flash.alert = "アカウントが無効になりました。"
      redirect_to :admin_root
    end
  end

  TIMEOUT = 60.minutes

  def check_timeout
    if current_administrator
      if session[:admin_last_access_time] >= TIMEOUT.ago
        session[:admin_last_access_time] = Time.current
      else
        session.delete(:administrator_id)
        flash.alert = "セッションがタイムアウトしました。"
        redirect_to :admin_login
      end
    end
  end
end
