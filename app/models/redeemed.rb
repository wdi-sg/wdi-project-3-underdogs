class Redeemed < ApplicationRecord
  belongs_to :reward
  belongs_to :user

end
