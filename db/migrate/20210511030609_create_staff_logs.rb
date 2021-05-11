class CreateStaffLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :staff_logs do |t|
      t.integer :log_id
      
      t.timestamps
    end
  end
end
