# frozen_string_literal: true

class ContactRepository < ApplicationRepository
  class << self
    def contacts_by_account(account_id)
      scope.where(account_id:)
    end

    def contacts_by_account_and_email(account_id, emails)
      scope.where({ account_id:, email: emails })
    end

    def create_invitations_for(account_id, contacts_emails)
      scope.where({ email: contacts_emails, account_id: }).update({ invite_status: :invited, invite_date: Date.today })
    end
  end
end
