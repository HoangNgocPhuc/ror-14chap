class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t ".applications.logged_in_user.pls_login"
    redirect_to login_url
  end

   def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end
end
