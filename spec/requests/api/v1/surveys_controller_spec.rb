# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/api/v1/team_morale/surveys", type: :request do
  include_context "login_user"
  path "/api/v1/team_morale/surveys" do
    post "Creates a Survey" do
      security [ Bearer: [] ]
      tags "Surveys"
      consumes "application/json"
      produces "application/json"
      parameter name: :survey, in: :body, schema: {
        type: :object,
        properties: {
          team_id: { type: :integer },
          deadline: { type: :date },
          period: { type: :string },
          period_value: { type: :integer },
          year: { type: :integer },
          survey_url: { type: :string },
          description: { type: :string },
        },
        required: [ "team_id", "deadline", "period", "period_value", "year", "survey_url", "description" ]
      }
      parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"

      response "200", "survey created" do
        consumes "application/json"
        let(:team) { create(:team) }
        let(:survey) {
            { "team_id": team.id,
              "deadline": Date.today + 1.month,
              "period": "month",
              "period_value": Date.today.month,
              "year": Date.today.year,
              "description": "TEST monthly survey",
              "survey_url": "www.ficticia.com", }
          }
        run_test!
      end

      response "400", "invalid request" do
        consumes "application/json"
        let(:survey) {
          { "deadline": Date.today + 1.month,
          "period": "month",
          "period_value": Date.today.month,
          "year": Date.today.year,
          "description": "TEST monthly survey",
          "survey_url": "www.ficticia.com", }
        }
        run_test!
      end
    end

    get("surveys list") do
      security [ Bearer: [] ]
      tags "Surveys"
      consumes "application/json"
      response 200, "successful" do
        let(:survey) { create(:survey, id: 1) }
        run_test! do |response|
          expect(response.body).not_to be_empty
          expect(response).to have_http_status(:success)
        end
      end
    end
  end

  path "/api/v1/team_morale/surveys/{id}" do
    delete("close survey") do
      security [ Bearer: [] ]
      tags "Surveys"
      consumes "application/json"
      produces "application/json"
      parameter name: :id, in: :path, type: :string
      parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"
      response 200, "successful" do
        let(:id) { create(:survey).id }
        run_test! do |response|
          expect(response.body).not_to be_empty
          expect(response).to be_truthy
          expect(Survey.first.status == "closed")
        end
      end
    end
  end
end
