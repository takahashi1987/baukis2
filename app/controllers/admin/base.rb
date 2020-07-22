class Admin::Base < ApplicationController
  helper_method :current_administrator
  before_action :authorize

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
end
