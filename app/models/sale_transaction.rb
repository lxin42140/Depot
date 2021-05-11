class SaleTransaction < ApplicationRecord
    has_many :sale_transaction_line_items, dependent: :destroy
    has_one :customer
end
