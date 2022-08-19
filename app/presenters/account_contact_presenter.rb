# frozen_string_literal: true

class AccountContactPresenter < ApplicationPresenter
  ATTRS = %i[id first_name last_name email]
  METHODS = %i[contact]
  ASSOCIATIONS = []

  private
    def contact
      "#{first_name} #{last_name} #{email}"
    end
end
