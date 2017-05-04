class Reward < ApplicationRecord
  # has_many :redeemed
  has_and_belongs_to_many :users
end
