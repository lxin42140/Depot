class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username
      t.string :password
      t.integer :access_right_enum
      t.string :type

      t.timestamps
    end
  end
end
