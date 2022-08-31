# frozen_string_literal: true

class TeamsOudatedMetricsJob < ApplicationJob
  # repeat "every week at 3am"
  queue_as :default

  def perform
    teams_with_metrics = TeamRepository.all.includes(:metrics)
    teams_with_metrics.map do |team|
      data = team.metrics.where("extract(month from date) >= ?", 1.months.ago.month)
      if data.empty?
        RequestTeamMetricsJob.perform_later(team.board_id, team.id)
      end
      # else means the team metrics are already updated
    end
  end
end
