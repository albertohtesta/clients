class CreateTeamBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :team_balances do |t|
      t.float :balance
      t.date :balance_date
      t.integer :team_id
      t.integer :account_id

      t.timestamps
    end
    add_index :team_balances, :team_id
    add_index :team_balances, :account_id
  end
end
