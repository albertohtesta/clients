class AddDeletedAtToProjectsAccounts < ActiveRecord::Migration[7.0]
  def up
    add_column :projects, :deleted_at, :timestamp
    add_column :accounts, :deleted_at, :timestamp
  end

  def down
    remove_column :projects, :deleted_at, :timestamp
    remove_column :accounts, :deleted_at, :timestamp
  end
end
