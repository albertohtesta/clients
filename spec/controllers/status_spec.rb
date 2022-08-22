# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey, type: :request do
  describe "GET status#index" do
    it "can't find survey when the id doen't exist" do
      @survey = create(:survey, id: 1)
      get "/api/v1/team_morale/surveys/2/status"
      expect(response).to have_http_status(:not_found)
    end

    it "can create survey" do
      # @survey = build_stubbed(:survey)
      @survey = create(:survey)
      get "/api/v1/team_morale/surveys/#{@survey.id}/status"
      expect(response).to have_http_status(:ok)
    end
  end
end
