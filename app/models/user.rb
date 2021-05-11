class User < ApplicationRecord::Base
  enum access_right: {
      customer: 1,
      manager: 2
    }
  validates :first_name, :last_name, :email, :username, :password, :access_right_enum, presence: true
  validates :email, :username, uniqueness: true
  has_secure_password
  #validates that the two password match
    
end

##
#t.integer :user_id
#t.string :first_name
#t.string :last_name
#t.string :email
#.string :username
#t.string :password
#t.integer :access_right_enum
#t.string :type
 