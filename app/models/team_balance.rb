# frozen_string_literal: true

class TeamBalance < ApplicationRecord
  has_many :metrics, as: :related

  belongs_to :team
  belongs_to :account

  validates :balance, :balance_date, :account_id, :team_id, presence: true
end
