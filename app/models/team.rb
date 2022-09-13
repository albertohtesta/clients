# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :collaborators_teams
  has_many :collaborators, through: :collaborators_teams
  has_many :metrics, as: :related
  has_many :investments
  has_many :team_requirements
  has_many :surveys
  has_many :team_balances
  has_many :accounts, through: :team_balances

  belongs_to :team_type
  belongs_to :project

  validates :added_date, presence: true
  validates :board_id, uniqueness: true
end
