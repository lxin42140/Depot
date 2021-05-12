class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception
    before_action :update_allowed_parameters, if: :devise_controller?
    before_action :set_current_user
    
    def set_current_user
      User.current_user = current_user
    end

    protected
      def update_allowed_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :first_name, :last_name, :email, :password, :access_right_enum)}
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :first_name, :last_name, :email, :password, :current_password)}
      end

      def check_access(access_right)
        if access_right == User.access_rights[:customer] && !User.isCustomer
          flash[:error] = "Customers only!"
          redirect_to root_path
        elsif access_right == User.access_rights[:manager] && User.isCustomer
          flash[:error] = "Managers only!"
          redirect_to root_path
        end
        rescue NullPointerException
          flash[:error] = "Please login first!"
          redirect_to "/users/sign_in"
      end

end
