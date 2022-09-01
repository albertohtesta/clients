# frozen_string_literal: true

class TeamBalance < ApplicationRecord
  has_many :metrics, as: :related

  belongs_to :team
  belongs_to :account, optional: true

  validates :balance, :balance_date, :team_id, presence: true
  enum seniority: SENIORITY_TYPES
end
