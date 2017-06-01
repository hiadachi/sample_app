require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception
  include SessionsHelper
  
  private

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        
        #flash[:danger] = "Please log in."
        flash[:danger] = i18n_field(:plslogin)
        redirect_to login_url
      end
    end
    
    def i18n_scope
      self.class.name.underscore.gsub(/_controller/, '').split('/')
    end
    
    def i18n_field(field)
      t(field, scope: i18n_scope)
    end
    
end
