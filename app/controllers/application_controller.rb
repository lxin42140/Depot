class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception
    before_action :update_allowed_parameters, if: :devise_controller?
    before_action :set_current_cart
    
    def set_current_cart
      cart = Cart.new
      if User.isCustomer(current_user) && current_user.cart.present? == false
        cart.user = current_user
        cart.save!
        Cart.current_cart = cart
      elsif User.isCustomer(current_user)
        cart.id = current_user.cart.id
        cart.sale_transaction_line_items = current_user.cart.sale_transaction_line_items.where(:is_sold => false)
        Cart.current_cart = cart
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
        if access_right == User.access_rights[:customer] && !User.isCustomer(current_user)
          flash[:error] = "Customers only!"
          redirect_to root_path
        elsif access_right == User.access_rights[:manager] && User.isCustomer(current_user)
          flash[:error] = "Managers only!"
          redirect_to root_path
        end
        rescue NoUserLoggedInException
          flash[:error] = "Please login first!"
          redirect_to "/users/sign_in"
      end

end
