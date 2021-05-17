class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  #*..*
  has_many :products_staffs, class_name: "ProductsStaffs"
  has_many :products, through: :products_staffs

  #0..*
  has_many :sale_transactions

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :email, :username, :password, :access_right_enum, presence: true
  validates :email, :username, uniqueness: true

  cattr_accessor :current_user
  
  enum access_right: {
    customer: 1,
    admin: 2
  }

  def self.isCustomer
    raise NoUserLoggedInException.new "No user is logged in!" if User.current_user.nil?
    return User.current_user.access_right_enum == 1 ? true : false
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
