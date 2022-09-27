# frozen_string_literal: true

class TeamRequirementRepository < ApplicationRepository
  class << self
    def role_deb_by_account(account_id)
      scope.where({ collaborator_id: nil, account_id: })
    end
  end
end
