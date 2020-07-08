class Admin::Base < ApplicationController
  helper_method :current_administrator

  private

  def current_administrator
    if session[:administrator_id]
      @current_administrator ||= Administrator.find(session[:administrator_id])
    end
  end
end
