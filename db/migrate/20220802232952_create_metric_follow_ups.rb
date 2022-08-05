class CreateMetricFollowUps < ActiveRecord::Migration[7.0]
  def change
    create_table :metric_follow_ups do |t|
      t.date :follow_date
      t.string :metric_type
      t.references :account, null: false, foreign_key: true
      t.references :manager, null: false, index: true, foreign_key: { to_table: :collaborators }
      t.text :mitigation_strategy

      t.timestamps
    end
  end
end
