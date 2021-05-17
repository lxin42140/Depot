class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_many :products_staffs, class_name: "ProductsStaffs"
  has_many :products, through: :products_staffs
  has_many :sale_transactions
  has_one :cart

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :email, :username, :password, :access_right_enum, presence: true
  validates :email, :username, uniqueness: true

  
  enum access_right: {
    customer: 1,
    admin: 2
  }

  def self.isCustomer(user)
    raise NoUserLoggedInException.new "No user is logged in!" if user.nil?
    return user.access_right_enum == 1 ? true : false
  end 

end
