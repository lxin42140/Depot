class AddUserToSaleTransaction < ActiveRecord::Migration[6.1]
  def change
    add_column :sale_transactions, :user_id, :string, index: true
    add_column :sale_transactions, :integer, :string, index: true
  end
end
