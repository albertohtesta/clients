# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Accounts", type: :request do
  before(:each) do
    stub_request(:get, "https://cognito-idp.us-west-1.amazonaws.com/local/.well-known/jwks.json").
    with(
      headers: {
     "Accept" => "*/*",
     "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
     "Host" => "cognito-idp.us-west-1.amazonaws.com",
     "User-Agent" => "Ruby"
      }).
    to_return(status: 200, body: "", headers: {})
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
