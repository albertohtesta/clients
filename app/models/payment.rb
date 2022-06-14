class Payment < ApplicationRecord
  belongs_to :account
  validates :cut_off_date, :payday_limit, presence:true
end
