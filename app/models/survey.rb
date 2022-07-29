class Survey < ApplicationRecord
  belongs_to :team
  enum status: [:open, :closed]
  enum period: [:month, :quarter, :year]
end
