class Product < ApplicationRecord
    has_many :staff_logs
    has_many :staffs, through: :staff_logs

    validates :name, :description, :unit_price, presence: true
    validates :unit_price, numericality: {greater_than_or_equal_to: 0.01}

end
