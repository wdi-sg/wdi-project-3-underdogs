class User < ApplicationRecord
  has_and_belongs_to_many :rewards
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :income
  has_one :bank_account_info
  has_many :transactions

  validates_date :dob, :on => :update, :before => lambda { 18.years.ago }, :allow_blank => true
  validates :id_no, :on => :update, format: { with: /((?i)^[SFTG]\d{7}[A-Z]$)/, message: "This is not a valid ID"}, :allow_blank => true

  validates :postal_code, :on => :update, format: { with: /(^\d{6,6}$)/, message: "Please enter a valid postal code"}, :allow_blank => true

  validates :mobile_no, :on => :update, format: { with: /(^\d{8,8}$)/, message: "Please enter a valid mobile number"}, :allow_blank => true

end
