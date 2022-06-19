# frozen_string_literal: true

class AddStatusToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_reference :accounts, :account_status, null: false, foreign_key: true
  end
end
