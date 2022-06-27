# frozen_string_literal: true

class FollowUpsRepository < ApplicationRepository
  class << self
    # TO DO: Pass as arg the object
    def by_account_manager(id)
      AccountFollowUps.joins(:account).where("account.manager_id" => id)
    end
  end
end
