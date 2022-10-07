# frozen_string_literal: true

module MetricPriority
  class VelocityCalculatorRepository < ApplicationRepository
    def initialize(account, average_value, last_monthly_metric)
      @account = account
      @average_value = average_value
      @last_monthly_metric = last_monthly_metric
    end

    def high_rate?
      return false if last_monthly_metric.nil?
      average_value < (total_points_required * 0.60)
    end

    def medium_rate?
      return false if last_monthly_metric.nil?
      average_value.between?(total_points_required * 0.60, total_points_required * 0.99)
    end

    def total_points_required
      total_collabs_in_account * 10
    end

    private
      attr_reader :account, :average_value, :last_monthly_metric

      def total_collabs_in_account
        # TODO: replase position with a constant or catalog
        @total_collabs_in_account ||= Collaborator.includes(:teams).where({
          teams: { id: account.teams.ids }, position: "SOFTWARE ENGINEER"
        }).count
      end
  end
end
