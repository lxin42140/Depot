class SaleTransaction < ApplicationRecord
    has_many :sale_transaction_line_items, dependent: :destroy
    belongs_to :customer

    #validations
    validates :total_line_item, :total_quantity, :total_amount, :transaction_date, presence: true
    validates :total_amount, numericality: {greater_than_or_equal_to: 0.01}
    validates :total_line_item, numericality: {greater_than: 0}
    validates :total_quantity, numericality: {greater_than: 0}
end
