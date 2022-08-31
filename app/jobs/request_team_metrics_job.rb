# frozen_string_literal: true

class RequestTeamMetricsJob < ApplicationJob
  # repeat 'every week at 3am'
  queue_as :default
  METRICS_API_BI_URL = ENV.fetch("BASE_URL_BI_API", "") + "/TeamPerformanceMetrics"

  def perform(board_id, team_id)
    params = { BoardId: board_id, GroupBy: "Month", ToDate: Date.today.strftime("%Y-%m"), FromDate: 1.months.ago.strftime("%Y-%m") }

    request = Requests::NetHttpLib.new(url: METRICS_API_BI_URL)
    request.with_query_params(params)
    response = request.resolve

    if response
      puts "API Response success", JSON.parse(response, symbolize_names: true)
      TeamMetricsService.save_team_metrics(team_id, JSON.parse(response, symbolize_names: true))
    else
      puts "API Response Error", response.to_json
    end
  end
end
