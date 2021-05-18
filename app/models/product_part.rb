class ProductPart < ApplicationRecord
  belongs_to :product, dependent: :destroy 
end
