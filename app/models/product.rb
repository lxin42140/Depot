class Product < ApplicationRecord
    has_many :products_staffs, class_name: "ProductsStaffs"
    has_many :users, through: :products_staffs
    has_many_attached :images, dependent: :destroy
    has_many :product_parts
    
    validates :name, :description, :unit_price, presence: true
    validates :unit_price, numericality: {greater_than_or_equal_to: 0.01}
    
    def is_product_referenced_by_line_items
        if SaleTransactionLineItem.find_by_product_id(self.id).nil?
            return false
        end 
        return true
    end
end
