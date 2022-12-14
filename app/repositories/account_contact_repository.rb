# frozen_string_literal: true

class AccountContactRepository < ApplicationRepository
  class << self
    def contacts_by_account(account_id)
      scope.where(account_id:)
    end
  end
end
