class AccountStatus < ApplicationRecord
  validates :status, presence: true
end
