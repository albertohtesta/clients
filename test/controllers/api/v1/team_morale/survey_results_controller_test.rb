# frozen_string_literal: true

require "test_helper"
module Api
  module V1
    module Team_morale
      class SurveyResultsControllerTest < ActionDispatch::IntegrationTest
        def survey
          @survey ||= create(:survey)
        end

        setup do
          survey
        end

        test "must get a response" do
          get api_v1_team_morale_survey_results_url(), params: {
            initial_month: survey.deadline.month,
            end_month: survey.deadline.month,
            year: survey.deadline.year,
            team_id: survey.team_id,
            type: "global"
          }

          assert_response :success
        end

        test "must get results" do
          get api_v1_team_morale_survey_results_url(), params: {
            initial_month: survey.deadline.month,
            end_month: survey.deadline.month,
            year: survey.deadline.year,
            team_id: survey.team_id,
            type: "global"
          }

          assert_not_empty response.body
        end
      end
    end
  end
end
