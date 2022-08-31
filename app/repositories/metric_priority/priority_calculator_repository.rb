# frozen_string_literal: true

module MetricPriority
  class PriorityCalculatorRepository < ApplicationRepository
    def initialize(account, metric_type)
      @account = account
      @metric_type = metric_type
    end

    def priority
      {
        amount: calculate_amount,
        alert: nivel_of_priority
      }
    end

    private
      attr_reader :account, :metric_type

      def calculate_amount
        return 0 if account_metric_result.empty?

        amount = find_metric(account_metric_result)
        amount["value"] / amount["amount_of_metrics_by_type"]
      end

      def nivel_of_priority
        return true if high_rate? || medium_rate?

        false
      end

      def account_metric_result
        @account_metric_result ||= account.metrics
          .where(date: date_of_last_metric.at_beginning_of_month..date_of_last_metric.end_of_month)
          .where(indicator_type: metric_type)
          .select("indicator_type, sum(value) as value, count(indicator_type) as amount_of_metrics_by_type")
          .group("indicator_type")
      end

      def date_of_last_metric
        last_record = account.metrics.where(indicator_type: metric_type).last

        return 1.month.ago if last_record.nil?

        last_record["date"]
      end

      def find_metric_limit(metric_limits)
        metric_limits.find_by(indicator_type: metric_type)
      end

      def find_metric(metric)
        metric.find_by(indicator_type: metric_type)
      end

      def high_rate?
        return false if account_metric_result.empty?

        high_metric_limit = find_metric_limit(high_metric_limits)
        result = find_metric(account_metric_result)["value"]
        result.between?(high_metric_limit.min, high_metric_limit.max)
      end

      def medium_rate?
        return false if account_metric_result.empty?

        medium_metric_limit = find_metric_limit(medium_metric_limits)
        result = find_metric(account_metric_result)["value"]
        result.between?(medium_metric_limit.min, medium_metric_limit.max)
      end

      def high_metric_limits
        @high_metric_limits ||= MetricLimit.select("high_priority_min AS min", "high_priority_max AS max", "indicator_type")
      end

      def medium_metric_limits
        @medium_metric_limits ||= MetricLimit.select("medium_priority_min AS min", "medium_priority_max AS max", "indicator_type")
      end
  end
end
