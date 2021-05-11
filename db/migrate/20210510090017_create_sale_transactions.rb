class CreateSaleTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :sale_transactions do |t|
      t.integer :transaction_id
      t.integer :total_line_item
      t.integer :total_quantity
      t.decimal :total_amount, precision: 8, scale: 2
      t.date :transaction_date

      t.timestamps
    end
  end
end
