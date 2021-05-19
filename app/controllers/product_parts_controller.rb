class ProductPartsController < ApplicationController
    before_action :set_product_part, only: %i[ show edit update destroy ]
    before_action only: [:index, :show, :new, :create, :edit, :update, :destroy] do 
      self.check_access(User.access_rights[:manager])
    end

  def index
    @product_parts = ProductPart.all
  end

  def show
  end

  def new
    @product_part = ProductPart.new
    @products = Product.all
  end

  def edit
    @products = Product.all
  end

  def create
      @product_part = ProductPart.new(product_part_params)
      @product_part.product = Product.find(params[:product_id])
      
      respond_to do |format|
        if @product_part.save
          format.html { redirect_to @product_part, notice: "Product part was successfully created." }
          format.js
          format.json { render :show, status: :created, location: @product_part }
        else
          format.js { render :new } # to show form validation errors
          format.html { redirect_to @product_part, status: :unprocessable_entity }
          format.json { render json: @product_part.errors, status: :unprocessable_entity }
        end
      end
  end

  def update
    @product_part.product = Product.find(params[:product_id])
    respond_to do |format|
      if @product_part.update(product_part_params)
        format.html { redirect_to @product_part, notice: "Product part was successfully updated." }
        format.js
        format.json { render :show, status: :ok, location: @product_part }
      else
        format.js { render :new } # to show form validation errors
        format.html { redirect_to @product_part, status: :unprocessable_entity }
        format.json { render json: @product_part.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product_part.destroy
      respond_to do |format|
        format.html { redirect_to product_parts_url}
        format.json { head :no_content }
      end
  end

  private
  
    def set_product_part
      @product_part = ProductPart.find(params[:id])
    end

    def product_part_params
      params.require(:product_part).permit(:product_id, 
                                            :name, 
                                            :id,
                                            :date_expired,
                                            :description
                                    )
    end
end
