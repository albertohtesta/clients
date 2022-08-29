# frozen_string_literal: true

class TeamBalanceRepository < ApplicationRepository
  class << self
    def retrieve_team_by_id(team_idid)
      scope.includes(:teams).find_by({ id: team_id })
    end

    def count_collaborators(id)
      scope.find_by(id:).collaborators.where.count
    end

    def count_junior_collaborators(id)
      scope.find_by(id:).collaborators.where(seniority: "JUNIOR").count
    end

    def count_middle_collaborators(id)
      scope.find_by(id:).collaborators.where(seniority: "MIDDLE").count
    end

    def count_senior_collaborators(id)
      scope.find_by(id:).collaborators.where(seniority: "SENIOR").count
    end
  end
end
