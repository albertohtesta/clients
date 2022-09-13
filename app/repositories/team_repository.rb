# frozen_string_literal: true

class TeamRepository < ApplicationRepository
  class << self
    def find_by_id(id)
      scope.includes(:collaborators).find_by(id:)
    end

    def retrieve_teams(account_id)
      scope.includes(:accounts).where(accounts: { id: account_id })
    end
  end
end
