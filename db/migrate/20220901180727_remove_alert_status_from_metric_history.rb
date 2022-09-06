class RemoveAlertStatusFromMetricHistory < ActiveRecord::Migration[7.0]
  def change
    remove_column(:metric_histories, :alert_status)
    add_column(:metric_follow_ups, :alert_status, :integer)
  end
end
