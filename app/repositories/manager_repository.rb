# frozen_string_literal: true

class ManagerRepository < ApplicationRepository
  class << self
    def with_accounts_by_id(id)
      scope.includes(accounts: [ :account_status, :projects, :payments]).find_by_id(id)
    end

    protected
      def model
        Collaborator
      end
  end
end