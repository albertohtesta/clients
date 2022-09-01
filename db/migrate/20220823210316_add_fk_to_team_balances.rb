class AddFkToTeamBalances < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :team_balances, :teams
    add_foreign_key :team_balances, :accounts
  end
end
