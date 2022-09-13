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
  end
end
