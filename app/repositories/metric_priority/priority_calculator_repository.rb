# frozen_string_literal: true

module MetricPriority
  class PriorityCalculatorRepository < ApplicationRepository
    def self.last_follow_up_date(account_id)
      metrics_follow_up = MetricFollowUp.where(account_id:)
      .where.not(follow_date: [nil])
      .order(follow_date: :desc).first
      return metrics_follow_up.follow_date unless metrics_follow_up.nil?
      nil
    end

    def initialize(account, metric_type)
      @account = account
      @metric_type = metric_type
    end

    def priority
      {
        amount: average_value,
        alert:,
        data_follow_up: json_follow_up,
        attended_after_metric:
      }
    end

    private
      attr_reader :account, :metric_type

      def attended_after_metric
        date_of_last_metric.present? && last_follow_up_date.present? && last_follow_up_date >= 7.days.ago.to_date
      end

      def last_follow_up_date
        last_follow_up.nil? ? nil : last_follow_up.follow_date
      end

      def last_follow_up
        @last_follow_up ||= MetricFollowUp.order("follow_date DESC").find_by(
          metric_type:,
          account_id: account.id
        )
      end

      def date_of_last_metric
        return 1.month.ago if last_metric.nil?
        last_metric["date"]
      end

      def last_metric
        @last_metric ||= find_by_type(account.metrics.order("date DESC"))
      end

      def json_follow_up
        if last_follow_up.nil?
          return JSON.parse(empty_follow_up.to_json)
        end
        follow_up = last_follow_up.dup
        follow_up.attributes = empty_follow_up # take metric.id and other basic values
        JSON.parse(follow_up.to_json(except: [:created_at, :updated_at]))
      end

      def empty_follow_up
        # using metric.id to find the type. TODO: use "metric-type" for tracking follow-ups
        ref_id = last_metric ? last_metric.id : nil
        {
          id: ref_id,
          account_id: account.id,
          manager_id: account.manager_id,
          metric_type:
        }
      end

      def alert
        return alert_for_velocity if metric_type == METRICS_TYPES[:velocity]

        return "high" if high_rate?

        if medium_rate?
          return attended_after_metric ? "medium" : "high"
        end

        "low"
      end

      def alert_for_velocity
        MetricPriority::VelocityCalculatorRepository.new(account, average_value, account_last_metric_monthly).has_alert?
      end

      def average_value
        return 0 if account_last_metric_monthly.nil?
        account_last_metric_monthly["value"] / account_last_metric_monthly["amount_of_metrics_by_type"]
      end

      def account_last_metric_monthly
        @account_last_metric_monthly ||= find_by_type(account.metrics
          .where(date: date_of_last_metric.at_beginning_of_month..date_of_last_metric.end_of_month)
          .select("indicator_type, sum(value) as value, count(indicator_type) as amount_of_metrics_by_type")
          .group("indicator_type"))
      end

      def high_rate?
        return false if account_last_metric_monthly.nil?
        average_value.between?(high_metric_limit.min, high_metric_limit.max)
      end

      def medium_rate?
        return false if account_last_metric_monthly.nil?
        average_value.between?(medium_metric_limit.min, medium_metric_limit.max)
      end

      def find_by_type(metric_records)
        metric_records.find_by(indicator_type: metric_type)
      end

      def high_metric_limit
        @high_metric_limit ||= find_by_type(MetricLimit.select("high_priority_min AS min", "high_priority_max AS max"))
      end

      def medium_metric_limit
        @medium_metric_limit ||= find_by_type(MetricLimit.select("medium_priority_min AS min", "medium_priority_max AS max"))
      end
  end
end
