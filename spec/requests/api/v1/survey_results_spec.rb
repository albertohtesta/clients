# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "api/v1/team_morale/survey_results", type: :request do
  path "/api/v1/team_morale/survey_results" do
    get("list survey results") do
      tags "Surveys"
      parameter name: :period, in: :query, type: :string
      parameter name: :year, in: :query, type: :string
      parameter name: :team_id, in: :query, type: :string
      parameter name: :processing_type, in: :query, type: :string

      let(:period) { "0" }
      let(:year) { "2022" }
      let(:team_id) { "1" }
      let(:processing_type) { "A" }
      produces "application/json"

      response 200, "successful" do
        run_test! do |response|
          expect(response.body).not_to be_empty
          expect(response).to have_http_status(:success)
        end
      end
    end

    get("list survey results with missing parameter") do
      tags "Surveys"
      parameter name: :period, in: :query, type: :string
      parameter name: :year, in: :query, type: :string
      parameter name: :processing_type, in: :query, type: :string

      let(:period) { "0" }
      let(:year) { "2022" }
      let(:processing_type) { "A" }

      produces "application/json"

      response 400, "invalid request" do
        run_test! do |response|
          expect(response.body).to eq("{\"message\":\"Parameters missing\"}")
        end
      end
    end
  end
end
