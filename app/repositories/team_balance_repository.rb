# frozen_string_literal: true

class TeamBalanceRepository < ApplicationRepository
  class << self
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
