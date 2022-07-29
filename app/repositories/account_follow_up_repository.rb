# frozen_string_literal: true

class AccountFollowUpRepository < ApplicationRepository
  class << self
    # TO DO: Pass as arg the object
    def by_account_manager(id)
      scope.includes(:account).where(account: { manager_id: id })
    end
  end
end