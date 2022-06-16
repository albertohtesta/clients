# frozen_string_literal: true

class CreateAccountStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :account_statuses do |t|
      t.string :status, null: false

      t.timestamps
    end
  end
end
