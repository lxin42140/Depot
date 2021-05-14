class CartsController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: %i[ show edit update destroy ]
  before_action only: [:index, :show, :new, :edit, :create, :update, :destroy] do 
    self.check_access(User.access_rights[:customer])
  end
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  #GET /carts or /carts.json
  def index
    @cart = Cart.new
    @cart.sale_transaction_line_items = []
    # add line items that are not marked as sold from current cart
    for line_item in Cart.current_cart.sale_transaction_line_items
      if line_item[:is_sold] == false 
        @cart.sale_transaction_line_items << line_item
      end 
    end
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
    if Cart.current_cart.user_id == User.current_user[:id]
      # remove all sale transaction line items associated with the cart
      ids_to_delete = []
      for item in Cart.current_cart.sale_transaction_line_items
        ids_to_delete << item.id
      end
      # destroy_all will delete all associated relations
      SaleTransactionLineItem.where(:id => ids_to_delete).delete_all
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Your cart is currently empty' }
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

 # GET /carts/1 or /carts/1.json
  # def show
  #     Cart.current_cart
  # end

# GET /carts/new
  # def new
  #   @cart = Cart.new
  # end

  # GET /carts/1/edit
  # def edit
  # end

  # POST /carts or /carts.json
  # def create()
  #   @cart = Cart.new(cart_params)

  #   respond_to do |format|
  #     if @cart.save
  #       format.html { redirect_to @cart, notice: "Cart was successfully created." }
  #       format.json { render :show, status: :created, location: @cart }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @cart.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end