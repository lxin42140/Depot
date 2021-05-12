class Cart < ApplicationRecord
    has_many :sale_transaction_line_items, dependent: :destroy

    def add_product(product)
        current_item = sale_transaction_line_items.find_by(product_id: product.id)
        if current_item
            current_item.quantity += 1
            current_item[:subtotal] += product[:unit_price]
        else
            current_item = sale_transaction_line_items.build(product_id: product.id)
            current_item[:subtotal] = product[:unit_price]
        end
        current_item
    end

    def total_price
        sale_transaction_line_items.to_a.sum { |item| item.total_price }
    end
        
end
