# frozen_string_literal: true

class MetricHistoryRepository < ApplicationRepository
  class << self
    def last_status(id)
      scope.where(metric_follow_ups_id: id).last
    end

    # ToDo: this gonna change after demo because the db relationships it's going to change and this code is not really good
    def update_historial(**args)
      ActiveRecord::Base.transaction do
        scope.create!(metric_follow_ups_id: args[:id], alert_status: args[:alert_status], date: Date.today)
        MetricFollowUp.update!(args[:id], mitigation_strategy: args[:mitigation_strategy])
      end
    end
  end
end
