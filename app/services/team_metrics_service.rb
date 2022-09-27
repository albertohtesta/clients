# frozen_string_literal: true

class TeamMetricsService
  class << self
    def save_team_metrics(team_id, metrics)
      metrics.map do |month, metric|
        MetricRepository.create([
          { value: metric[:performance].to_s, indicator_type: :performance, date: month.to_s.to_date, related_type: "Team", related_id: team_id },
          { value: metric[:completedPoints].to_s, indicator_type: :velocity, date: month.to_s.to_date, related_type: "Team", related_id: team_id }
        ])
      end
    end
  end
end
