class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action only: [:create, :edit, :update, :destroy, :new] do 
    self.check_access(User.access_rights[:manager])
  end

  # GET /products or /products.json
  def index
    @products = Product.where(is_deleted: false).order(:id)
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

      respond_to do |format|
        if @product.save
          create_log(@product, "create")        
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
    respond_to do |format|
      if @product.update(product_params)
        create_log(@product, "update")        
        
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
      create_log(@product, "delete")     

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
      params.require(:product).permit(:product_id, :name, :description, :unit_price, images: [])
    end

    def create_log(product, operation)
        log = ProductsStaffs.new
        log.product= product
        log.user = current_user
        log[:log_time] = Date.today
        log[:operation] = operation
        log.save!
    end
  
end

# GET /products/1 or /products/1.json
# def show
# end