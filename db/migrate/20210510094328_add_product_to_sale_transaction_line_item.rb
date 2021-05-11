class AddProductToSaleTransactionLineItem < ActiveRecord::Migration[6.1]
  def change
    add_column :sale_transaction_line_items, :product_id, :integer, index: true
  end
end
