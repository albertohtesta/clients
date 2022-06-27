# frozen_string_literal: true

class AddDataToImportFromApis < ActiveRecord::Migration[7.0]
  def up
    add_column :accounts, :salesforce_id, :string, null: false, default: 0
    add_column :accounts, :balance, :integer, default: 0
    add_column :accounts, :blended_rate, :decimal, default: 0.00
    add_column :accounts, :gross_profit, :decimal, default: 0.00
    add_column :accounts, :payroll, :decimal, default: 0.00
    add_column :accounts, :total_expenses, :decimal, default: 0.00
    add_column :accounts, :total_revenue, :decimal, default: 0.00
  end

  def down
    remove_column :accounts, :salesforce_id, :string
    remove_column :accounts, :balance, :integer
    remove_column :accounts, :blended_rate, :decimal
    remove_column :accounts, :gross_profit, :decimal
    remove_column :accounts, :payroll, :decimal
    remove_column :accounts, :total_expenses, :decimal
    remove_column :accounts, :total_revenue, :decimal
  end
end
