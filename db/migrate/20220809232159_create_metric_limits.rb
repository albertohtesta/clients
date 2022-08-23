class CreateMetricLimits < ActiveRecord::Migration[7.0]
  def change
    create_table :metric_limits do |t|
      t.string :indicator_type
      t.string :label
      t.integer :low_priority_min
      t.integer :low_priority_max
      t.integer :medium_priority_min
      t.integer :medium_priority_max
      t.integer :high_priority_min
      t.integer :high_priority_max

      t.timestamps
    end
  end
end
