class AddMonthlyAmountToTeams < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :monthly_amount, :float
  end
end
