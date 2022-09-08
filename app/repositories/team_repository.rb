# frozen_string_literal: true

class TeamRepository < ApplicationRepository
  class << self
    def find_by_id(id)
      scope.includes(:collaborators).find_by(id:)
    end

    def find_all_collaborators(id)
      scope.find_by(id:).collaborators
    end

    def find_all_junior_collaborators(id)
      scope.find_by(id:).collaborators.where(seniority: "JUNIOR")
    end

    def find_all_middle_collaborators(id)
      scope.find_by(id:).collaborators.where(seniority: "MIDDLE")
    end

    def find_all_senior_collaborators(id)
      scope.find_by(id:).collaborators.where(seniority: "SENIOR")
    end

    def find_teams_of_project(project_id)
      scope.select(:id).find_by(project_id:)
    end
  end
end
