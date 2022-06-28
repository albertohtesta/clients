# frozen_string_literal: true

# Base class for repositories
class AccountRepository < ApplicationRepository
  class << self
    def first_or_initialize_by_salesforce_id(salesforce_id)
      scope.where(salesforce_id:).first_or_initialize
    end

    def import(accounts)
      accounts.map do |item|
        ActiveRecord::Base.transaction do
          account = AccountRepository.first_or_initialize_by_salesforce_id(item[:account][:Id])
          account.update_from_salesforce(item[:account], item[:contacts])
          Contact.update_contacts_from_salesforce(account, item[:contacts])
          Project.update_project_by_salesforce(account, item[:opportunity])
          account.attributes.slice("name", "id", "salesforce_id")
        end
      end
    end
  end
end
