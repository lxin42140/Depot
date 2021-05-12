class SaleTransactionLineItemsController < ApplicationController
  before_action :set_sale_transaction_line_item, only: %i[ show edit update destroy ]
  before_action :require_customer

  # GET /sale_transaction_line_items or /sale_transaction_line_items.json
  def index    
    @sale_transaction_line_items = SaleTransactionLineItem.all
  end

end
  # # GET /sale_transaction_line_items/1 or /sale_transaction_line_items/1.json
  # def show
  # end

  # # GET /sale_transaction_line_items/new
  # def new
  #   @sale_transaction_line_item = SaleTransactionLineItem.new
  # end

  # # GET /sale_transaction_line_items/1/edit
  # def edit
  # end

  # # POST /sale_transaction_line_items or /sale_transaction_line_items.json
  # def create
  #   @sale_transaction_line_item = SaleTransactionLineItem.new(sale_transaction_line_item_params)

  #   respond_to do |format|
  #     if @sale_transaction_line_item.save
  #       format.html { redirect_to @sale_transaction_line_item, notice: "Sale transaction line item was successfully created." }
  #       format.json { render :show, status: :created, location: @sale_transaction_line_item }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @sale_transaction_line_item.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /sale_transaction_line_items/1 or /sale_transaction_line_items/1.json
  # def update
  #   respond_to do |format|
  #     if @sale_transaction_line_item.update(sale_transaction_line_item_params)
  #       format.html { redirect_to @sale_transaction_line_item, notice: "Sale transaction line item was successfully updated." }
  #       format.json { render :show, status: :ok, location: @sale_transaction_line_item }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @sale_transaction_line_item.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /sale_transaction_line_items/1 or /sale_transaction_line_items/1.json
  # def destroy
  #   @sale_transaction_line_item.destroy
  #   respond_to do |format|
  #     format.html { redirect_to sale_transaction_line_items_url, notice: "Sale transaction line item was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_sale_transaction_line_item
  #     @sale_transaction_line_item = SaleTransactionLineItem.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def sale_transaction_line_item_params
  #     params.require(:sale_transaction_line_item).permit(:item_id, :quantity, :subtotal, :decimal)
  #   end

