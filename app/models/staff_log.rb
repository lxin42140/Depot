class StaffLog < ApplicationRecord
    belongs_to :product
    belongs_to :staff

    def can_create?()
end
