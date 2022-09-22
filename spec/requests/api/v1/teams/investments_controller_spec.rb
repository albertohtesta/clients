# frozen_string_literal: true

require "rails_helper"
require "swagger_helper"

RSpec.describe "Team Investments", type: :request do
  include WebmockHelper

  let(:Authorization) { @token }
  let(:team) { create(:team) }
  let(:team_id) { team.id }

  context "on investment data existing for a team" do
    let!(:investment) { create(:investment, team:, date: 1.month.ago.to_date) }

    path "/api/v1/teams/{team_id}/investments/quarters" do
      get "Investments for a quarter" do
        produces "application/json"
        parameter name: :team_id, in: :path
        response(200, "successful") do
          run_test!
        end
      end
    end

    path "/api/v1/teams/{team_id}/investments/months" do
      get "Investments for the previous month" do
        produces "application/json"
        parameter name: :team_id, in: :path
        response(200, "successful") do
          run_test!
        end
      end
    end
  end

  context "on investment data non existent" do
    path "/api/v1/teams/{team_id}/investments/quarters" do
      get "Investment data not found" do
        produces "application/json"
        parameter name: :team_id, in: :path
        response(404, "not found") do
          run_test!
        end
      end
    end
  end
end
