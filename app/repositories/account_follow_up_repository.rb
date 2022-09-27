# frozen_string_literal: true

class AccountFollowUpRepository < ApplicationRepository
  class << self
    # TO DO: Pass as arg the object
    def by_account_manager(id)
      scope.includes(:account).where(account: { manager_id: id })
    end

    def last_follow_up_by_account(account_id)
      scope.where(account_id:)
    end
  end
end
