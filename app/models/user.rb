class User < ApplicationRecord
  has_and_belongs_to_many :users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :income
  has_one :bank_account_info
  has_many :transactions


end
