# frozen_string_literal: true

class MetricRepository < ApplicationRepository
  class << self
    def team_metrics_per_month(filter_params)
      team_metrics = team_metrics_in_this_year(filter_params)
      return if team_metrics.empty?

      (1...Date.today.month).map do |month_idx|
        monthly_metrics = team_metrics.where("extract(month from date) = ?", month_idx)
        monthly_metrics = last_team_metrics_in_a_month(filter_params, month_idx) if monthly_metrics.empty?

        { value: promediate_metrics(monthly_metrics), label: Date::MONTHNAMES[month_idx] }
      end
    end

    def team_metrics_per_quarter(filter_params)
      team_metrics = team_metrics_in_this_year(filter_params)
      return if team_metrics.empty?

      (1..Date.today.month).step(3).map do |quarter|
        quarter_metrics = team_metrics.where("extract(month from date) IN (?)", (quarter..quarter + 3))
        quarter_metrics = last_team_metrics_in_a_month(filter_params, quarter + 3) if quarter_metrics.empty?

        { value: promediate_metrics(quarter_metrics), label: "Q#{quarter / 3 + 1}" }
      end
    end

    private
      def promediate_metrics(metrics)
        return 0 if metrics.empty?

        metrics.map { |metric| metric["value"] }.sum / metrics.size
      end

      def team_metrics_in_this_year(filter_params)
        dates_range = Date.today.beginning_of_year..Date.today
        scope.select([:value, :date]).where(filter_params.merge({ date: dates_range }))
      end

      def last_team_metrics_in_a_month(filter_params, month_idx)
        if filter_params[:indicator_type] == METRICS_TYPES[:balance]
          return [scope.select([:value, :date]).where(filter_params).where("date <= ? ", Date::MONTHNAMES[month_idx].to_date).last]
        end
        []
      end
  end
end
