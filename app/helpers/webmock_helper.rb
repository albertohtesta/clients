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
  def login_as(collaborator)
    jwk = JWT::JWK.new(OpenSSL::PKey::RSA.new(2048), "optional-kid")
    payload = { username: collaborator.uuid,
                sub: collaborator.uuid,
                "cognito:groups" => ["client"],
                user_attributes: [
                                  { name: "sub", value: collaborator.uuid },
                                  { name: "email_verified", value: "true" },
                                  { name: "email", value: collaborator.email }
                                ]
              }

    #               [{"username"=>"600be2e4-c80a-42cf-9e77-e11d15b15d51",
    #   "role"=>"client",
    #   "user_attributes"=>
    #    [{"name"=>"sub", "value"=>"600be2e4-c80a-42cf-9e77-e11d15b15d51"},
    #     {"name"=>"email_verified", "value"=>"true"},
    #     {"name"=>"email", "value"=>"merrill_jacobs@ledner.com"}]},
    #  {"kid"=>"optional-kid", "alg"=>"RS256"}]
    headers = { kid: jwk.kid }

    keys_body = { keys: [jwk.export] }.to_json
    stub_request(:any, URI(TokenService::URL)).to_return(body: keys_body, status: 200, headers: {})

    @token = JWT.encode(payload, jwk.keypair, "RS256", headers)
  end
end
