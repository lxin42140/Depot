class AddSaleTransactionIdToSaleTransactionLineItem < ActiveRecord::Migration[6.1]
  def change
    add_column :sale_transaction_line_items, :sale_transaction_id, :integer, index: true
  end
end
