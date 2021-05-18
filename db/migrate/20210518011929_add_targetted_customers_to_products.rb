class AddTargettedCustomersToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :targetted_customers, :string
  end
end
