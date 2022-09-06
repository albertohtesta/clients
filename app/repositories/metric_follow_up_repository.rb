# frozen_string_literal: true

class MetricFollowUpRepository < ApplicationRepository
  class << self
    def mitigation_strategy(id)
      scope.find_by(id:).mitigation_strategy
    end

    # ToDo: this gonna change after demo because the db relationships it's going to change and this code is not really good
    def update_historial(**args)
      ActiveRecord::Base.transaction do
        scope.update!(args[:id], alert_status: args[:alert_status], mitigation_strategy: args[:mitigation_strategy])
        MetricHistory.create!(
          metric_follow_ups_id: args[:id],
          date: Date.today,
          alert_status: args[:alert_status],
          mitigation_strategy: args[:manager_id]
        )
      end
    end
  end
end
