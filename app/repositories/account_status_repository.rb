# frozen_string_literal: true

# Base class for repositories
class AccountStatusRepository < ApplicationRepository
  class << self
    def new_project_status
      scope.where(status_code: :new_project).first
    end

    def in_development_status
      scope.where(status_code: :in_development).first
    end

    def finished_status
      scope.where(status_code: :finished).first
    end

    def cancelled_status
      scope.where(status_code: :cancelled).first
    end
  end
end
