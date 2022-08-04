# frozen_string_literal: true

class ManagerRepository < ApplicationRepository
  class << self
    def with_accounts_by_id(id)
      CollaboratorRepository.by_role_name("Account Manager")
        .includes(accounts: [ :account_status, :projects, :payments, :team_requirements])
        .find_by_id(id)
    end

    protected
      def model
        Collaborator
      end
  end
end
