# frozen_string_literal: true

class ProjectRepository < ApplicationRepository
  class << self
    def find_projects_of_account(account_id)
      scope.select(:id).find_by(account_id:)
    end
  end
end
