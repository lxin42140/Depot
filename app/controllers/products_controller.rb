class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action only: [:create, :edit, :update, :destroy, :new] do 
    self.check_access(User.access_rights[:manager])
  end

  # GET /products or /products.json
  def index
    #only show products not deleted
    @products = Product.where(is_deleted: false).order(:id)
    @user = nil
    #assign user to current user only if the user is manager
    if User.current_user.present? && User.current_user[:access_right_enum] == 2
      @user = User.current_user
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product
  end

  # POST /products or /products.json
  def create
      @product = Product.new(product_params)
      @user = User.current_user

      respond_to do |format|
        if @product.save
          ProductsStaffs.create_log(User.current_user[:id], @product[:id], "create")        
          format.html { redirect_to products_url, notice: "Product was successfully created." }
          format.js
          format.json { render :show, status: :created, location: @product }
        else
          format.js { render :new } # to show form validation errors
          format.html { redirect_to products_url, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    @user = User.current_user

    respond_to do |format|
      if @product.update(product_params)
        ProductsStaffs.create_log(User.current_user[:id], @product[:id], "update")        
        @products = Product.where(is_deleted: false).order(:id)
        format.html { redirect_to products_url, notice: "Product was successfully updated." }
        format.js
        format.json { render :show, status: :ok, location: @product }
      else
        format.js { render :new } # to show form validation errors
        format.html { redirect_to products_url, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @user = User.current_user
    #if product is in cart, cannot delete
    if @product.is_product_referenced_by_line_items
      flash[:error] = "Product is in use!"
      respond_to do |format|
        format.html { redirect_to products_url}
        format.json { head :no_content }
      end
      return
    else 
      # soft delete
      @product.update(is_deleted: true)
      ProductsStaffs.create_log(User.current_user[:id], @product[:id], "delete")        
      @products = Product.where(is_deleted: false).order(:id)
      respond_to do |format|
        format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
        format.js
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:product_id, :name, :description, :unit_price)
    end
  
end

# GET /products/1 or /products/1.json
# def show
# end