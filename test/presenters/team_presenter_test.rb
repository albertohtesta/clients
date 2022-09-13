# frozen_string_literal: true

require "test_helper"

class TeamPresenterTest < ActiveSupport::TestCase
  def team
    @team ||= build(:team)
  end

  def team_presenter
    @team_presenter ||= TeamPresenter.new(@team)
  end

  test "must return json" do
    team
    team_presenter

    expected_json = {
      "id" => nil,
      "added_date" => @team.added_date,
      "team_type_id" => @team.team_type_id,
      "project_id" => @team.project_id,
      "board_id" => @team.board_id,
    }

    assert_equal expected_json, team_presenter.json
  end
end
