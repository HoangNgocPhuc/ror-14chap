class SetLanguagesController < ApplicationController
  def en
    I18n.locale = :en
    set_session_and_redirect
  end

  def vn
    I18n.locale = :vn
    set_session_and_redirect
  end

  private

  def set_session_and_redirect
    session[:locale] = I18n.locale
    redirect_to :back
  end
end
