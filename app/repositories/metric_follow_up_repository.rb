# frozen_string_literal: true

class MetricFollowUpRepository < ApplicationRepository
  class << self
    def mitigation_strategy(id)
      scope.find_by(id:).mitigation_strategy
    end
  end
end
