# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "api/v1/team_morale/surveys", type: :request do
  before(:each) do
    create(:survey, id: 1)
  end

  path "/api/v1/team_morale/surveys/not_found" do
    get("Survey does not exist") do
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
      response 200, "successful" do
        run_test! do |response|
          expect(response.body).not_to be_empty
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end