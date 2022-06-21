# frozen_string_literal: true

class AddManagerIdToAccounts < ActiveRecord::Migration[7.0]
  def up
    add_reference :accounts, :manager, null: true, index: true, foreign_key: { to_table: :collaborators },
                                       after: :account_uuid
  end

  def down
    remove_column :accounts, :manager_id
  end
end
