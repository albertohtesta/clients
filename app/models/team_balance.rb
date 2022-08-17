# frozen_string_literal: true

class TeamBalance < ApplicationRecord
  has_many :metrics, as: :related

  belongs_to :team
  belongs_to :account

  validates :balance, :balance_date, presence: true
end
