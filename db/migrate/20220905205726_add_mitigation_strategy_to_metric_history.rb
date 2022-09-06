class AddMitigationStrategyToMetricHistory < ActiveRecord::Migration[7.0]
  def change
    add_column(:metric_histories, :mitigation_strategy, :text)
    add_column(:metric_histories, :alert_status, :integer)
    add_column(:metric_histories, :manager_id, :integer)
  end
end
