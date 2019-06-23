class ApplicationController < ActionController::Base
    private 
      #ログインユーザーのみに許可
      def require_login 
          if session[:user_id] == nil
              redirect_to "/login"
          end
      end
      
      #現在ログインしているユーザー
      def current_user
          @current_user = User.find_by(id: session[:user_id])
      end
      
      #ログインしているユーザーは禁止
      def not_current_user 
        if current_user
          flash[:danger] = "すでにログインしています。"
          redirect_to  root_url
        end
      end

end
