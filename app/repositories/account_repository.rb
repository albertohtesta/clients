# frozen_string_literal: true

class AccountRepository < ApplicationRepository
  class << self
    def first_or_initialize_by_salesforce_id(salesforce_id)
      scope.where(salesforce_id:).first_or_initialize
    end

    def import(resources)
      ActiveRecord::Base.transaction do
        account = AccountRepository.first_or_initialize_by_salesforce_id(resources[:account][:Id])
        account.update_from_salesforce(resources[:account], resources[:contacts])
        Contact.update_contacts_from_salesforce(account, resources[:contacts])
        Project.update_project_by_salesforce(account, resources[:opportunity])
        account.attributes.slice("name", "id", "salesforce_id")
      end
    end

    def role_debt_by_id(id)
      scope.find_by(id:).team_requirements.where(collaborator: nil).count
    end

    def account_project_by_account_id(account_id)
      scope.includes(:projects).find(account_id)
    end

    def find_customer_info(uuid)
      scope.find_by(uuid:)
    end
  end
end
