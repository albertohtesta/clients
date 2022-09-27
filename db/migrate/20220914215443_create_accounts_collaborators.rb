class CreateAccountsCollaborators < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts_collaborators do |t|
      t.references :account, null: false, foreign_key: true
      t.references :collaborator, null: false, foreign_key: true
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
