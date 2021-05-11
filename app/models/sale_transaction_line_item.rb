class SaleTransactionLineItem < ApplicationRecord
    belongs_to :sale_transaction
    has_one :product

    validates :quantity, :sub_total, presence: true
    validates :sub_total, numericality: {greater_than_or_equal_to: 0.01}
    validates :quantity, numericality: {greater_than: 0}
end
