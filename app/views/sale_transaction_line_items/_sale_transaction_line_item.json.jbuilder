json.extract! sale_transaction_line_item, :id, :item_id, :quantity, :subtotal, :decimal, :created_at, :updated_at
json.url sale_transaction_line_item_url(sale_transaction_line_item, format: :json)
