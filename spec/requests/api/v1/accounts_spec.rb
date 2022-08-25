# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Accounts", type: :request do
  before(:each) do
    stub_cognito_uri
  end

  context "Accounts" do
    let(:Authorization) { @token }

    path "/api/v1/accounts" do
      get("list accounts") do
        tags "Accounts"
        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"

        response(401, "Unauthorized") do
          run_test!
        end
      end
    end
  end
end
