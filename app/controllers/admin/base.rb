class Admin::Base < ApplicationController
  helper_method :current_admin

  private

  def current_admin
    if session[:administrator_id]
      @current_administrator ||= Administrator.find(session[:administrator_id])
    end
  end
end
