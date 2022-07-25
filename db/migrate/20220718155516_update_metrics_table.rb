class UpdateMetricsTable < ActiveRecord::Migration[7.0]
  def change
    remove_reference :metrics, :project, foreign_key: true
    add_reference :metrics, :team, foreign_key: true

    rename_column :metrics, :from_date, :date
    remove_column :metrics, :to_date
    remove_column :metrics, :group_by
  end
end
