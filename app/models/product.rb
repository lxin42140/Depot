class Product < ApplicationRecord
    has_many :staff_logs
    has_many :staffs, through: :staff_logs

    validates :name, :description, :unit_price, presence: true
    validates :unit_price, numericality: {greater_than_or_equal_to: 0.01}

    def is_product_referenced_by_line_items
        if SaleTransactionLineItem.find_by_product_id(self.id).nil?
            puts "******************is_product_referenced_by_line_items: True"
            return true
        end 
        return false
    end
end
