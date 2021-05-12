class SaleTransactionLineItem < ApplicationRecord
    has_one :sale_transaction
    belongs_to :cart, dependent: :destroy
    belongs_to :product
    
    validates :quantity, :subtotal, presence: true
    validates :subtotal, numericality: {greater_than_or_equal_to: 0.01}
    validates :quantity, numericality: {greater_than: 0}

    def total_price
        product.unit_price * quantity
    end
        
end
