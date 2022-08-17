# frozen_string_literal: true

class TeamMetricsService
  class << self
    def load_team_metrics(team_id, metrics)
      # TODO: temporally metrics, mujst be replaced with the BI API response
      metrics = { "January": { "estimatedPoints": 82, "completedPoints": 68, "performance": 81 } }

      metrics.map do |month, metric|
        Metric.create!([
          { metrics: metric[:performance].to_s, indicator_type: :performance, date: Date.today, related_type: "Team", related_id: team_id },
          { metrics: metric[:completedPoints].to_s, indicator_type: :velocity, date: Date.today, related_type: "Team", related_id: team_id }
        ])
      end
    end
  end
end
