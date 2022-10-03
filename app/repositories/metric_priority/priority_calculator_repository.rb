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
        alert: nivel_of_priority,
        data_follow_up: create_metric_follow_ups
      }
    end

    private
      attr_reader :account, :metric_type

      def create_metric_follow_ups
        @metric_follow_ups = MetricFollowUp.find_or_create_by(
           created_at: date_of_last_metric.beginning_of_day..date_of_last_metric.end_of_day,
           metric_type:,
           account_id: account.id
         ) do |metric|
           metric.follow_date = nil
           metric.metric_type = METRICS_TYPES[:"#{metric_type}"]
           metric.account_id = account.id
           metric.manager_id = account.manager_id
           metric.mitigation_strategy = ""
           metric.alert_status = 0
           metric.created_at = date_of_last_metric
         end

        JSON.parse(@metric_follow_ups.to_json(except: [:created_at, :updated_at]))
      end

      def calculate_amount
        return 0 if account_metric_result.blank?

        amount = find_metric(account_metric_result)
        amount["value"] / amount["amount_of_metrics_by_type"]
      end

      def nivel_of_priority
        return "high" if high_rate?

        return "medium" if medium_rate?

        "low"
      end

      def account_metric_result
        @account_metric_result ||= metrics_by_type
      end

      def metrics_by_type
        metrics_by_teams
          .where(date: date_of_last_metric.at_beginning_of_month..date_of_last_metric.end_of_month)
          .where(indicator_type: metric_type)
          .select("indicator_type, sum(value) as value, count(indicator_type) as amount_of_metrics_by_type")
          .group("indicator_type")
      end

      def metrics_by_teams
        @metrics_by_teams ||= teams.map { |team| team.metrics }.first
      end

      def teams
        @teams ||= account.teams_accounts.includes(:metrics)
      end

      def date_of_last_metric
        last_record = metrics_by_teams.where(indicator_type: metric_type)&.last

        return 1.month.ago if last_record.blank?

        last_record["date"]
      end

      def find_metric_limit(metric_limits)
        metric_limits.find_by(indicator_type: metric_type)
      end

      def find_metric(metric)
        metric.find_by(indicator_type: metric_type)
      end

      def high_rate?
        return false if account_metric_result.blank?

        high_metric_limit = find_metric_limit(high_metric_limits)
        result = find_metric(account_metric_result)["value"]
        result.between?(high_metric_limit.min, high_metric_limit.max)
      end

      def medium_rate?
        return false if account_metric_result.blank?

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
