# frozen_string_literal: true

class CollaboratorsTeam < ApplicationRecord
  belongs_to :collaborator
  belongs_to :team

  after_update :calculate_team_balance
  after_destroy :calculate_team_balance

  private
    def calculate_team_balance
      team_balance = TeamBalanceService.new(self.team.id).process
      TeamBalance.new({ team_id: self.team.id, balance_date: Date.today, balance: team_balance }).save
    end
end
