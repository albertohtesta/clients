# frozen_string_literal: true

class TeamBalanceRepository < ApplicationRepository
  class << self
    def retrieve_team_by_id(team_id)
      scope.includes(:teams).find_by({ id: team_id })
    end

    def all_collaborators(id)
      scope.find_by(id:).collaborators
    end

    def all_junior_collaborators(id)
      scope.find_by(id:).collaborators.where(seniority: "JUNIOR")
    end

    def all_middle_collaborators(id)
      scope.find_by(id:).collaborators.where(seniority: "MIDDLE")
    end

    def all_senior_collaborators(id)
      scope.find_by(id:).collaborators.where(seniority: "SENIOR")
    end
  end
end
