# frozen_string_literal: true

require "test_helper"

class MetricRepositoryTest < ActiveSupport::TestCase
  setup do
    @team = create(:team)
    create(:metric, team: @team)
    create(:metric, team: @team, date: 1.months.ago)
    @filter_params = { team_id: @team.id, indicator_type: "performance" }
  end

  test "show team metrics grouped by month" do
    team_metrics = MetricRepository.team_metrics_per_month(@filter_params)

    assert team_metrics.first.key?(:value)
    assert team_metrics.first[:label] == Date::MONTHNAMES[1]
  end

  test "show team metrics grouped by quarter" do
    team_metrics = MetricRepository.team_metrics_per_quarter(@filter_params)

    assert team_metrics.first.key?(:value)
    assert team_metrics.first[:label] == "Q1"
  end
end
