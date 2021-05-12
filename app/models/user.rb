class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, :email, :username, :password, :access_right_enum, presence: true
  validates :email, :username, uniqueness: true

  cattr_accessor :current_user
  
  enum access_right: {
    customer: 1,
    manager: 2
  }

  def self.isCustomer
    raise NullPointerException.new "No user is logged in!" if User.current_user.nil?
    @isCustomer
    User.current_user.access_right_enum == 1 ? @isCustomer = true : @isCustomer = false
    return @isCustomer
  end 
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
 