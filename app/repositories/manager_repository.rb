# frozen_string_literal: true

class ManagerRepository < ApplicationRepository
  class << self
    def model
      Collaborator
    end

    def with_accounts_by_id(id)
      scope.includes(:accounts).find_by_id(id)
    end
  end
end
