class CreateSaleTransactionLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :sale_transaction_line_items do |t|
      t.integer :item_id
      t.integer :quantity
      t.decimal :subtotal, precision: 8, scale: 2

      t.timestamps
    end
  end
end
