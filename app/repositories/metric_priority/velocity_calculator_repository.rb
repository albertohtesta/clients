# frozen_string_literal: true

module MetricPriority
  class VelocityCalculatorRepository < PriorityCalculatorRepository
    def initialize(account)
      super(account, METRICS_TYPES[:velocity])
    end

    def expected_points
      total_collabs_in_account * 10
    end

    protected
      def high_rate?
        return false if account_last_metric_monthly.nil? || expected_points.to_i == 0

        average_value < (expected_points * 0.60)
      end

      def medium_rate?
        return false if account_last_metric_monthly.nil? || expected_points.to_i == 0

        average_value.between?(expected_points * 0.60, expected_points * 0.99)
      end

    private
      def total_collabs_in_account
        # TODO: replase position with a constant or catalog
        @total_collabs_in_account ||= Collaborator.includes(:teams).where({
          teams: { id: account.teams.ids }, position: "SOFTWARE ENGINEER"
        }).count
      end
  end
end
