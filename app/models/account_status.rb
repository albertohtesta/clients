class AccountStatus < ApplicationRecord
  validates :name, presence: true
end
