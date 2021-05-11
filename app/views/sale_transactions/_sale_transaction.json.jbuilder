json.extract! sale_transaction, :id, :transaction_id, :total_line_item, :total_quantity, :total_amount, :decimal, :transaction_date, :Date, :created_at, :updated_at
json.url sale_transaction_url(sale_transaction, format: :json)
