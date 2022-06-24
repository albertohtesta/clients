class AddSlugToAccountStatus < ActiveRecord::Migration[7.0]
  def up
    add_column :account_statuses, :status_code, :string, null: :true
    add_index :account_statuses, :status_code, unique: true
  end

  def down
    remove_index :account_statuses, :status_code
    remove_column :account_statuses, :status_code, :string
  end
end
