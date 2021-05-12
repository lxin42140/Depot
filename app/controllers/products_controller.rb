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

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
      @product = Product.new(product_params)
  
      respond_to do |format|
        if @product.save
          format.html { redirect_to @product, notice: "Product was successfully created." }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /products/1 or /products/1.json
  # Staff log is created
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    #soft delete

    @product.update(is_deleted: true)

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
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
