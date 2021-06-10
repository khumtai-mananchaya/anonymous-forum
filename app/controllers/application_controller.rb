class ApplicationController < ActionController::Base
  before_action :set_current_user
      def set_current_user
        return unless session[:user_id]
        Current.user ||= User.find(session[:user_id])
      end
      def require_user_logged_in!
        # allows only logged in user
        redirect_to sign_in_path, alert: 'You must be signed in' if Current.user.nil?
      end
end
