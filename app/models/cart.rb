class Cart < ApplicationRecord
    has_many :sale_transaction_line_items, dependent: :destroy
    belongs_to :user
    validates :user_id, presence: true

    cattr_accessor :current_cart

    def add_product(product)
        current_item = sale_transaction_line_items.where("product_id = #{product.id} and is_sold = false")[0]
        if current_item.present?
            current_item[:quantity] += 1
            current_item[:subtotal] += product[:unit_price]
        else
            current_item = sale_transaction_line_items.build(product_id: product.id)
            current_item[:subtotal] = product[:unit_price]
        end
        current_item
    end

    def remove_product(product)
        current_item = sale_transaction_line_items.find_by(product_id: product.id)
        current_item.quantity -= 1;
        current_item[:subtotal] -= product[:unit_price]
        current_item
    end

    def total_price
        sale_transaction_line_items.where(:is_sold => false).to_a.sum { |item| item.total_price }
    end

end
