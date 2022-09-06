# frozen_string_literal: true

class MetricFollowUpPresenter < ApplicationPresenter
  ATTRS = %i[id follow_date metric_type account_id manager_id mitigation_strategy alert_status].freeze
end
