class Product < ApplicationRecord
    has_many :staff_logs
    has_many :staffs, through: :staff_logs
end
