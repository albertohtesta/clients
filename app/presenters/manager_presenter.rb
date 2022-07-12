# frozen_string_literal: true

class ManagerPresenter < ApplicationPresenter
  ATTRS = %i[id name email].freeze
  METHODS = [:accounts_count].freeze
  ASSOCIATIONS = [accounts: { only:
        %i[id name contact_name contact_email account_web_page],
          methods: %i[review_outdated? location tech_stacks
                    tools payment_status status details finance health productivity_kpis] }].freeze

  def accounts_count
    accounts.size
  end
end
