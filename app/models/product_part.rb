class ProductPart < ApplicationRecord
  belongs_to :product, dependent: :destroy 

  validates :name, :date_expired, presence: true
end
