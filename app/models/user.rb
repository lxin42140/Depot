class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum access_right: {
      customer: 1,
      manager: 2
    }
  validates :first_name, :last_name, :email, :username, :password, :access_right_enum, presence: true
  validates :email, :username, uniqueness: true
    
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
 