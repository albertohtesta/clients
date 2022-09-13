# frozen_string_literal: true

class TeamBalanceRepository < ApplicationRepository
  class << self
    def balance_by_team(team_id)
      scope.where(team_id:)
    end
  end
end
