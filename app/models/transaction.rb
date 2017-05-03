class Transaction < ApplicationRecord
  belongs_to :user, :bank_account_info
end
