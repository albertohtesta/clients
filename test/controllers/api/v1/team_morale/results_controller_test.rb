# frozen_string_literal: true

require "test_helper"
module Api
  module V1
    module Team_morale
      class ResultsControllerTest < ActionDispatch::IntegrationTest
        def survey
          @survey ||= create(:survey)
        end

        setup do
          survey
        end

        test "must get a response" do
          get api_v1_team_morale_results_url(), params: {
            initial_date: Date.today,
            end_date: Date.today + 1.months,
            team_id: survey.team_id,
            type: "global"
          }

          assert_response :success
        end

        test "must get surveys results" do
          get api_v1_team_morale_results_url(), params: {
            initial_date: survey.deadline,
            end_date: survey.deadline + 1.months,
            team_id: survey.team_id,
            type: "global"
          }

          assert_equal(response.parsed_body,
            [
              [
                  "Pregunta 1",
                  "Balance de vida",
                  100
              ],
              [
                  "Pregunta 2",
                  "Balance de vida",
                  100
              ],
              [
                  "Pregunta 3",
                  "Orgullo",
                  100
              ],
              [
                  "Pregunta 4",
                  "Orgullo",
                  100
              ]
          ]
          )

        end
      end
    end
  end
end
