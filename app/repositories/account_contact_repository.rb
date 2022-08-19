# frozen_string_literal: true

class AccountContactRepository < ApplicationRepository
  class << self
    def find_contacts_by_account(account_id)
      scope.includes(:accounts).where(accounts: { id: account_id })
    end
  end
end
