# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "api/v1/team_morale/surveys", type: :request do
  include_context "login_user"
  before(:each) do
    create(:survey, id: 1, remote_survey_id: "Eo9SGMK4")
  end

  path "/api/v1/team_morale/surveys/not_found" do
    get("Survey does not exist") do
      tags "Surveys"
      security [ Bearer: [] ]
      produces "application/json"
      response 404, "not found" do
        run_test! do |response|
          expect(response.body).not_to be_empty
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  path "/api/v1/team_morale/surveys/2" do
    get("Survey does not exist") do
      tags "Surveys"
      security [ Bearer: [] ]
      produces "application/json"
      response 404, "not found" do
        run_test! do |response|
          expect(response.body).not_to be_empty
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  path "/api/v1/team_morale/surveys/1" do
    get("get survey status") do
      tags "Surveys"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      response 200, "successful" do
        before do |example|
          get_survey_stubs
          submit_request(example.metadata)
        end

        it "return a valid 200 response" do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
