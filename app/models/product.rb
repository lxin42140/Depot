class Product < ApplicationRecord
    has_many :products_staffs, class_name: "ProductsStaffs"
    has_many :users, through: :products_staffs
    has_many_attached :images
    has_many :product_parts
    accepts_nested_attributes_for :product_parts, allow_destroy: true
    
    validates :name, :description, :unit_price, :category, :model, :delivery, presence: true
    validates :unit_price, numericality: {greater_than_or_equal_to: 0.01}
    validate  :acceptable_images

    def is_product_referenced_by_line_items
        if SaleTransactionLineItem.find_by_product_id(self.id).nil?
            return false
        end 
        return true
    end

    def acceptable_images
        if images.count <= 0
            errors.add(:images, "Upload at least one image")
        end
    end 
    
    def thumbnail(image)
        return image.variant(resize: '300x200!').processed
    end

    def show_image(image)
        return image.variant(resize: '600x300!').processed
    end
end
