class CartsController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: %i[ show edit update destroy ]
  before_action only: [:index, :show, :new, :edit, :create, :update, :destroy] do 
    self.check_access(User.access_rights[:customer])
  end
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  #GET /carts or /carts.json
  def index
    @cart = Cart.current_cart
    @sale_transaction_line_items = Cart.current_cart.sale_transaction_line_items.where(:is_sold => false)
  end

  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    Cart.current_cart.sale_transaction_line_items.where(:is_sold => false).delete_all

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Your cart is currently empty' }
      format.js
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    def cart_params
      params.fetch(:cart, {})
    end

    def invalid_cart
      redirect_to root_path, notice: 'Invalid cart'
    end

end