class ProductPart < ApplicationRecord
  belongs_to :product

  validates :name, :date_expired, :description, presence: true
end
