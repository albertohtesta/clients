# frozen_string_literal: true

class TeamRepository < ApplicationRepository
  class << self
    def find_by_id(id)
      scope.includes(:collaborators).find_by(id:)
    end

    def find_all_collaborators(id)
      scope.find_by(id:).collaborators
    end

    def find_all_collaborators_by_seniority(id, seniority)
      scope.find_by(id:).collaborators.where(seniority:)
    end

    def find_teams_of_project(project_id)
      scope.select(:id).find_by(project_id:)
    end

    def retrieve_teams(account_id)
      scope.includes(:accounts).where(accounts: { id: account_id })
    end
  end
end
