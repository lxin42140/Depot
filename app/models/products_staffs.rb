class ProductsStaffs < ApplicationRecord
    # belongs_to :product
    # belongs_to :user

    def self.create_log(user_id, product_id, operation)
        @log = ProductsStaffs.new
        @log[:product_id] = product_id
        @log[:staff_id] = user_id
        @log[:log_time] = Date.today
        @log[:operation] = "update"
        @log.save!
    end
end
