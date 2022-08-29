# frozen_string_literal: true

class TeamRepository < ApplicationRepository
  class << self
    def find_by_id(id)
      scope.includes(:collaborators).find_by(id:)
    end
  end
end
