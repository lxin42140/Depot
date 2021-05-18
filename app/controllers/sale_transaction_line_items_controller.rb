class SaleTransactionLineItemsController < ApplicationController
  include CurrentCart
  
  before_action :set_cart, only: [:create]
  before_action :set_sale_transaction_line_item, only: %i[ show edit update destroy ]
  before_action only: [:index, :show, :new, :edit, :create, :update, :destroy] do 
    self.check_access(User.access_rights[:customer])
  end
  skip_before_action :verify_authenticity_token

  def create
    product = Product.find(params[:product_id])
    @sale_transaction_line_item = Cart.current_cart.add_product(product)

    respond_to do |format|
      if @sale_transaction_line_item.save!
        format.html { redirect_to "/my_cart", notice: "Item successfully added" }
        format.json { render :show, status: :created, location: @sale_transaction_line_item }
      else
        flash[:error] = "Could not update cart"
        format.html { redirect_to "/my_cart", status: :unprocessable_entity }
        format.json { render json: @sale_transaction_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if params[:increment]
      @sale_transaction_line_item.quantity += 1
    else 
      @sale_transaction_line_item.quantity -= 1
    end

    respond_to do |format|
      updated = false
      if (@sale_transaction_line_item.quantity <= 0 && @sale_transaction_line_item.delete) || @sale_transaction_line_item.save
        updated = true
      end

      unless updated == true
        flash[:error] = "Could not update cart"
        format.html { redirect_to "/my_cart", status: :unprocessable_entity }
        format.json { render json: @sale_transaction_line_item.errors, status: :unprocessable_entity }
      else
        @cart = Cart.current_cart
        @sale_transaction_line_items = Cart.current_cart.sale_transaction_line_items.where(:is_sold => false)
        
        format.html { redirect_to "/my_cart", notice: @message }
        format.js
        format.json { render :show, status: :ok, location: @sale_transaction_line_item }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale_transaction_line_item
      @sale_transaction_line_item = SaleTransactionLineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sale_transaction_line_item_params
      params.require(:sale_transaction_line_item).permit(:product_id, :quantity, :subtotal)
    end

end