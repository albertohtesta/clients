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
      scope.find_by(id:).collaborators.where(seniority: SENIORITY_TYPES[:junior])
    end

    def find_all_middle_collaborators(id)
      scope.find_by(id:).collaborators.where(seniority: SENIORITY_TYPES[:middle])
    end

    def find_all_senior_collaborators(id)
      scope.find_by(id:).collaborators.where(seniority: SENIORITY_TYPES[:senior])
    end
  end
end
