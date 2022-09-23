# frozen_string_literal: true

require "rails_helper"
require "swagger_helper"

RSpec.describe "Team Investments", type: :request do
  include WebmockHelper

  include_context "login_user"
  let(:team) { create(:team) }
  let(:team_id) { team.id }

  context "on investment data existing for a team" do
    let!(:investment) { create(:investment, team:, date: 1.month.ago.to_date) }

    path "/api/v1/teams/{team_id}/investments" do
      get "Investments for a quarter" do
        security [ Bearer: [] ]
        produces "application/json"
        parameter name: :team_id, in: :path
        parameter name: :group_by, in: :query
        response(200, "successful") do
          let(:group_by) { "quarter" }
          run_test!
        end
      end
    end

    path "/api/v1/teams/{team_id}/investments" do
      get "Investments for the previous month" do
        security [ Bearer: [] ]
        produces "application/json"
        parameter name: :team_id, in: :path
        parameter name: :group_by, in: :query
        response(200, "successful") do
          let(:group_by) { "monthly" }
          run_test!
        end
      end
    end
  end

  context "on investment data non existent" do
    path "/api/v1/teams/{team_id}/investments" do
      get "Investment data not found" do
        security [ Bearer: [] ]
        produces "application/json"
        parameter name: :team_id, in: :path
        parameter name: :group_by, in: :query

        response(404, "not found") do
          let(:group_by) { "quarter" }
          run_test!
        end
      end
    end
  end
end
