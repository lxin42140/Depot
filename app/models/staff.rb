class Staff < User
    has_many :staff_logs
    has_many :products, through: :staff_logs
end
