class CreateMetricHistory < ActiveRecord::Migration[7.0]
  def change
    create_table :metric_histories do |t|
      t.references :metric_follow_ups, null: false, foreign_key: true
      t.integer :alert_status, default: 0
      t.date :date, null: false

      t.timestamps
    end
  end
end
