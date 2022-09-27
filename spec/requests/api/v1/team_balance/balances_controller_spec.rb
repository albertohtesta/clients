# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Balances", type: :request do
  include_context "login_user"

  context "Team balances" do
    path "/api/v1/team_balance/balances" do
      get("list balances") do
        tags "Balances"
        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"

        response(200, "successful") do
          run_test!
        end
      end
    end
  end
end
