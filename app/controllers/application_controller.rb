class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception
    before_action :update_allowed_parameters, if: :devise_controller?
    before_action :set_current_user_and_cart
    
    def set_current_user_and_cart
      #assgin current user to logged in user
      User.current_user = current_user

      if User.isCustomer
        retrieve_or_create_cart
      end
      rescue NoUserLoggedInException
      
    end

    protected
      def update_allowed_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :first_name, :last_name, :email, :password, :access_right_enum)}
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :first_name, :last_name, :email, :password, :current_password)}
      end

      #KIV
      def check_access(access_right)
        if access_right == User.access_rights[:customer] && !User.isCustomer
          flash[:error] = "Customers only!"
          redirect_to root_path
        elsif access_right == User.access_rights[:manager] && User.isCustomer
          flash[:error] = "Managers only!"
          redirect_to root_path
        end
        rescue NoUserLoggedInException
          flash[:error] = "Please login first!"
          redirect_to "/users/sign_in"
      end

    private 

      # create a new cart for user if the user is not associated with a cart 
      # retrieve associated cart from user
      def retrieve_or_create_cart
        if Cart.find_by_user_id(User.current_user[:id]).nil?
          Cart.current_cart = Cart.add_new_cart_to_user(User.current_user[:id]) 
        else
          Cart.current_cart = Cart.find_by_user_id(User.current_user[:id])
        end
      end

end
