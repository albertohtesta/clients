# frozen_string_literal: true

# authenticate cognito user
class TokenService < CognitoService
  POOL_ID = ENV.fetch("AWS_COGNITO_USER_POOL", nil).freeze
  ISS = "https://cognito-idp.#{ENV.fetch("AWS_REGION", nil)}.amazonaws.com/#{POOL_ID}".freeze
  URL = "https://cognito-idp.#{ENV.fetch("AWS_REGION",
                                         nil)}.amazonaws.com/#{POOL_ID}/.well-known/jwks.json".freeze

  attr_reader :error

  def decode
    # begin
    Rollbar.error(ISS, "ISS")
    puts(ISS, "ISS")
    Rollbar.error(URL, "URL")
    puts(URL, "URL")
    Rollbar.error(jwt_config, "jwt_config")
    puts(jwt_config, "jwt_config")
    Rollbar.error(@user_object.to_json, "user object")
    puts(@user_object[:token], 'TOKEN')

    decoded_token = JWT.decode(@user_object[:token].gsub("Bearer ", ""), nil, true, { algorithm: 'RS256' })
    # rescue StandardError => e
    # @error = e
    # Rollbar.error(e, "error getting token service")
    # return false
    # end
    decoded_token
  end

  private
    def verification_uri
      @verification_uri ||= URI(URL)
    end

    def jwt_config
      resp = Net::HTTP.get_response(verification_uri)
      @jwt_config ||= JSON.parse(resp.body, symbolize_names: true)
    end
end
