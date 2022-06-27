# frozen_string_literal: true

class AddDataToImportFromApi < ActiveRecord::Migration[7.0]
  def up
    add_column :accounts, :client_satisfaction, :integer, default: 0
    add_column :accounts, :moral, :integer, default: 0
    add_column :accounts, :bugs_detected, :integer, default: 0
    add_column :accounts, :permanence, :integer, default: 0
    add_column :accounts, :productivity, :integer, default: 0
    add_column :accounts, :speed, :integer, default: 0
  end

  def down
    remove_column :accounts, :client_satisfaction, :integer
    remove_column :accounts, :moral, :integer
    remove_column :accounts, :bugs_detected, :integer
    remove_column :accounts, :permanence, :integer
    remove_column :accounts, :productivity, :integer
    remove_column :accounts, :speed, :integer
  end
end
