class CreateAccountsCollaboratorsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :accounts, :collaborators do |t|
      t.index %i[account_id collaborator_id]
      t.integer :status, default: 1
    end
  end
end
