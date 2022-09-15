# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Accounts", type: :request do
  let(:Authorization) { @token }

  before do
    contact = build(:contact)
    contact.save
    login_as(contact)
  end

  path "/api/v1/accounts" do
    get("list accounts") do
      tags "Accounts"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"

      response(200, "Account information") do
        run_test!
      end

      response(401, "Unauthorized") do
        let(:Authorization) { "" }
        run_test!
      end
    end
  end
end
