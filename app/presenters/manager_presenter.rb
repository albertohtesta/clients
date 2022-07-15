# frozen_string_literal: true

class ManagerPresenter < ApplicationPresenter
  ATTRS = %i[id name email].freeze
  METHODS = [:accounts_count, :accounts].freeze

  def accounts_count
    accounts.size
  end

  def accounts
    AccountPresenter.json_collection(__getobj__.accounts)
  end
end
