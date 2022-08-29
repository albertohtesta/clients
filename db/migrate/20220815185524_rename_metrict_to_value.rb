class RenameMetrictToValue < ActiveRecord::Migration[7.0]
  def up
    rename_column :metrics, :metrics, :value
    Metric.update_all(value: "0")
    change_column :metrics, :value, "integer USING CAST(value AS integer)"
  end

  def down
    rename_column :metrics, :value, :metrics
    change_column :metrics, :metrics, :text
  end
end
