class SaleTransactionLineItem < ApplicationRecord
    belongs_to :sale_transaction
    has_one :product
end
