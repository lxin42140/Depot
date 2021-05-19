json.extract! product_part, :id, :product_id, :name, :date_expired, :created_at, :updated_at
json.url product_part_url(product_part, format: :json)
