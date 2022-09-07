# frozen_string_literal: true

class TeamsOudatedMetricsJob < ApplicationJob
  def perform
    puts ">>Job Team metrics executing<<"

    teams_with_metrics = TeamRepository.all.includes(:metrics)
    teams_with_metrics.map do |team|
      data = team.metrics.where("extract(month from date) >= ?", 1.months.ago.month)

      RequestTeamMetricsJob.perform_later(team.board_id, team.id) if data.empty?
    end
  end
end
