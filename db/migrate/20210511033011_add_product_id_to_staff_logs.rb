class AddProductIdToStaffLogs < ActiveRecord::Migration[6.1]
  def change
    add_column :staff_logs, :product_id, :integer, index: true
    add_column :staff_logs, :staff_id, :integer, index: true
  end
end
