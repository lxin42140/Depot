class ProductPart < ApplicationRecord
  belongs_to :product

  validates :name, :date_expired, :description, :product_id, presence: true
end
