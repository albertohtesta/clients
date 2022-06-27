# frozen_string_literal: true

class AddLocationToAccount < ActiveRecord::Migration[7.0]
  def up
    add_column :accounts, :country, :string, after: :name
    add_column :accounts, :state, :string, after: :country
    add_column :accounts, :city, :string, after: :state
  end

  def down
    remove_column :accounts, :city, :string
    remove_column :accounts, :state, :string
    remove_column :accounts, :country, :string
  end
end
