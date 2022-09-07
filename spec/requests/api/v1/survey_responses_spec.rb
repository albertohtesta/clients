# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/api/v1/team_morale/surveys/:id", type: :request do
  before(:each) do
    @survey = create(:survey, id: 1, survey_url: "www.ficticia.com")
  end

  path "/api/v1/team_morale/surveys/1" do
    delete("close survey") do
      response 200, "successful" do
        run_test! do |response|
          expect(response.body).not_to be_empty
          expect(response).to have_http_status(:success)
        end
      end
    end
  end

  path "/api/v1/team_morale/surveys/1" do
    delete("close survey and change status") do
      response 200, "successful" do
        run_test! do |response|
          expect(@survey.reload.status).to eq("closed")
        end
      end
    end
  end

  path "/api/v1/team_morale/surveys/1" do
    delete("do not close survey that should not to be closed") do
      response 200, "not found" do
        run_test! do |response|
          @survey.current_answers = 0
          @survey.save
          expect(@survey.status).not_to eq("closed")
        end
      end
    end
  end

  path "/api/v1/team_morale/surveys/notfound" do
    delete("close survey that does not exist") do
      response 404, "not found" do
        run_test! do |response|
          expect(response.body).not_to be_empty
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
