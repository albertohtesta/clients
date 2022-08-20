# frozen_string_literal: true

class ContactRepository < ApplicationRepository
  class << self
    def contacts_by_account(account_id)
      scope.where(account_id:)
    end

    def find_by(*attrs)
      Contact.find_by(*attrs)
    end
  end
end
