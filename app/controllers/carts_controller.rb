class CartsController < ApplicationController
  before_action :set_cart, only: %i[ index destroy ]
  before_action only: [:index, :destroy] do 
    self.check_access(User.access_rights[:customer])
  end
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def index
    @sale_transaction_line_items = Cart.current_cart.sale_transaction_line_items.where(:is_sold => false)
  end

  def destroy
    @cart.sale_transaction_line_items.where(:is_sold => false).delete_all

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Your cart is currently empty' }
      format.js
      format.json { head :no_content }
    end
  end

  private
    def set_cart
      @cart = Cart.current_cart
    end

    def cart_params
      params.fetch(:cart, {})
    end

    def invalid_cart
      redirect_to root_path, notice: 'Invalid cart'
    end

end