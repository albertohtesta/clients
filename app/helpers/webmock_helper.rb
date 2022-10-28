# frozen_string_literal: true

# Mock cognito uri response
module WebmockHelper
  def stub_cognito_uri
    jwk = JWT::JWK.new(OpenSSL::PKey::RSA.new(2048), "optional-kid")
    payload = { data: "data" }
    headers = { kid: jwk.kid }

    keys_body = { keys: [jwk.export] }.to_json
    stub_request(:any, URI(TokenService::URL)).to_return(body: keys_body, status: 200, headers: {})

    @token = JWT.encode(payload, jwk.keypair, "RS256", headers)
  end

  # TODO: Use this method for tests instead of the stub_cognito_uri when login is ready to use
  # check the core-backend repo for reference
  def login_as(collaborator, user_type = "client")
    jwk = JWT::JWK.new(OpenSSL::PKey::RSA.new(2048), "optional-kid")
    payload = { username: collaborator.uuid,
                sub: collaborator.uuid,
                "cognito:groups" => [user_type],
                user_attributes: [
                                  { name: "sub", value: collaborator.uuid },
                                  { name: "email_verified", value: "true" },
                                  { name: "email", value: collaborator.email }
                                ]
              }
    headers = { kid: jwk.kid }

    keys_body = { keys: [jwk.export] }.to_json
    stub_request(:any, URI(TokenService::URL)).to_return(body: keys_body, status: 200, headers: {})

    @token = JWT.encode(payload, jwk.keypair, "RS256", headers)
  end

  def get_survey_stubs
    access_token = ENV.fetch("TYPE_FORM_ACCESS_TOKEN")
    stub_request(:get, "https://api.typeform.com/forms/Eo9SGMK4/responses").
    with(
      headers: {
        "Accept" => "*/*",
        "Authorization" => "Bearer #{access_token}",
        "Host" => "api.typeform.com"
      }
    ).
    to_return(
      status: 200,
      body: {
        "total_items": 2,
        "page_count": 1,
        "items": [
        ]
      }.to_json,
      headers: {}
    )

    stub_request(:patch, "https://api.typeform.com/forms/Eo9SGMK4").
    with(
      body: "[{\"op\":\"replace\",\"path\":\"/settings/is_public\",\"value\":false}]",
      headers: {
      "Accept" => "application/json",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Authorization" => "Bearer #{access_token}",
      "Content-Length" => "61",
      "Content-Type" => "application/json",
      "Host" => "api.typeform.com",
      "User-Agent" => "rest-client/2.1.0 (linux-musl x86_64) ruby/3.1.1p18"
      }).
    to_return(status: 200, body: "", headers: {})
  end
end
