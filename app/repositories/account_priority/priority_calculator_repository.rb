# frozen_string_literal: true

module AccountPriority
  class PriorityCalculatorRepository < ApplicationRepository
    def initialize(account, last_follow_up)
      @account = account
      @last_follow_up = last_follow_up
    end

    def high_priority
      return true if last_follow_up <= 1.months.ago
      are_there_a_metric_in_high_rate = metric_type.map { |metric_name| high_rate?(metric_name) }
      are_there_a_metric_in_high_rate.include?(true)
    end

    def medium_priority
      are_there_a_metric_in_medium_rate = metric_type.map do |metric_name|
        medium_rate?(metric_name)
      end
      are_there_a_metric_in_medium_rate.include?(true)
    end

    def priority
      return "high" if high_priority
      if medium_priority
        return (last_follow_up <= 1.weeks.ago) ? "high" : "medium"
      end
      "low"
    end

    private
      attr_reader :account, :last_follow_up

      def metric_type
        @metric_type ||= METRICS_TYPES.map { |_key, value| value }
      end

      def high_rate?(metric)
        high_metric_limit = find_metric_limit(high_metric_limits, metric)
        result = account_metric_result[metric]

        return if result.nil?

        result.between?(high_metric_limit.min, high_metric_limit.max)
      end

      def medium_rate?(metric)
        medium_metric_limit = find_metric_limit(medium_metric_limits, metric)
        result = account_metric_result[metric]

        return if result.nil?

        result.between?(medium_metric_limit.min, medium_metric_limit.max)
      end

      def find_metric_limit(metric_limits, metric)
        metric_limits.find_by(indicator_type: metric)
      end

      def account_metric_result
        @account_metric_result ||= account.metrics
          .where(date: 1.months.ago..Date.today)
          .group("indicator_type").sum("value")
      end

      def high_metric_limits
        @high_metric_limits ||= MetricLimit.select("high_priority_min AS min", "high_priority_max AS max", "indicator_type")
      end

      def medium_metric_limits
        @medium_metric_limits ||= MetricLimit.select("medium_priority_min AS min", "medium_priority_max AS max", "indicator_type")
      end
  end
end
