class ApplicationController < ActionController::Base
  helper_method :current_user
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end

    def require_login
      unless logged_in?
        flash[:alert] = "Você precisa estar logado para acessar esta página."
        redirect_to login_path
      end
    end


end
