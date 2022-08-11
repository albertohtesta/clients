class AddManaggerStartedDateToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :manager_started_date, :date
  end
end
