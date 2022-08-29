# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Accounts", type: :request do
  include WebmockHelper

  let(:user) { create(:contact) }
  let(:current_user) { user }
  before { login_as(user) }

  path "/api/v1/accounts" do
    get("list accounts") do
      tags "Accounts"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"

      response(200, "Authorized") do
        let(:Authorization) { @token }

        run_test!
      end

      response(401, "Unauthorized") do
        let(:Authorization) { "" }

        run_test!
      end
    end
  end
end
