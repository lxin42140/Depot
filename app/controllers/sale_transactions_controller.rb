class SaleTransactionsController < ApplicationController
  
  before_action only: [:index] do 
    self.check_access(User.access_rights[:customer])
  end

  def index
    @sale_transactions = current_user.sale_transactions
  end

  def create
    @sale_transaction = SaleTransaction.new
    
    line_items = Cart.current_cart.sale_transaction_line_items.select{|item| item.is_sold == false}
    
    transaction_created = false

    ActiveRecord::Base.transaction do
      @sale_transaction[:total_line_item] = 0
      @sale_transaction[:total_amount] = 0
      @sale_transaction[:total_quantity] = 0
      @sale_transaction[:transaction_date] = Date.today
      @sale_transaction.user = current_user

      for item in line_items do
        @sale_transaction[:total_line_item] += 1
        @sale_transaction[:total_amount] += item[:subtotal]
        @sale_transaction[:total_quantity] += item[:quantity]
        @sale_transaction.sale_transaction_line_items << item
        item[:is_sold] = true

        item.save!
      end

      if @sale_transaction.save!
        transaction_created = true
      end
    end 

    respond_to do |format|
      if transaction_created == true
        #send email
        OrderMailer.received(line_items, current_user).deliver_now

        format.html { redirect_to "/my_transactions", notice: "Sale transaction was successfully created." }
        format.json { render :show, status: :created, location: @sale_transaction }
      else
        flash[:error] = "Could not check out"
        format.html { redirect_to "/my_transactions", status: :unprocessable_entity }
        format.json { render json: @sale_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def sale_transaction_params
      params.require(:sale_transaction).permit(:transaction_id, :total_line_item, :total_quantity, :total_amount, :decimal, :transaction_date, :Date)
    end

end

  # POST /sale_transactions or /sale_transactions.json
  # def self.create
  #   @sale_transaction = SaleTransaction.new(sale_transaction_params)

  #   respond_to do |format|
  #     if @sale_transaction.save
  #       format.html { redirect_to @sale_transaction, notice: "Sale transaction was successfully created." }
  #       format.json { render :show, status: :created, location: @sale_transaction }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @sale_transaction.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  
  # GET /sale_transactions/1 or /sale_transactions/1.json
  # def show
  # end

  # # GET /sale_transactions/new
  # def new
  #   @sale_transaction = SaleTransaction.new
  # end

  # # GET /sale_transactions/1/edit
  # def edit
  # end
  
  # # PATCH/PUT /sale_transactions/1 or /sale_transactions/1.json
  # def update
  #   respond_to do |format|
  #     if @sale_transaction.update(sale_transaction_params)
  #       format.html { redirect_to @sale_transaction, notice: "Sale transaction was successfully updated." }
  #       format.json { render :show, status: :ok, location: @sale_transaction }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @sale_transaction.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /sale_transactions/1 or /sale_transactions/1.json
  # def destroy
  #   @sale_transaction.destroy
  #   respond_to do |format|
  #     format.html { redirect_to sale_transactions_url, notice: "Sale transaction was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end
