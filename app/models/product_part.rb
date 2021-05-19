class ProductPart < ApplicationRecord
  belongs_to :product

  validates :name, :date_expired, presence: true
end
