# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :collaborators_teams
  has_many :collaborators, through: :collaborators_teams
  has_many :metrics, as: :related
  has_many :investments
  has_many :team_requirements
  has_many :surveys
  has_many :team_balances

  belongs_to :team_type
  belongs_to :project

  validates :added_date, presence: true

  after_create :add_team_balance

  private
    def add_team_balance
      balance = TeamBalance.new
      balance.team_id = self.id
      balance.balance_date = self.balance_date
      balance.balance = TeamBalanceService.new(id).process
      balance.save
    end

    def balance_date
      Date.today
    end
end
