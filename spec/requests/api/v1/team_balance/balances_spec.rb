# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "api/v1/team_balance/balances", type: :request do
  context "Team balances" do
    let(:team) { create(:team) }

    path "/api/v1/team_balance/balances" do
      get("list balances") do
        tags "Balances"

        consumes "application/json"
        produces "application/json"
        parameter name: :team_id, in: :path, type: :integer, description: "id of the team"

        response(200, "successful") do
          let(:team_id) { Team.first }

          run_test!
        end
      end
    end
  end
end
