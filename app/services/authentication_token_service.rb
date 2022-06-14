class AuthenticationTokenService < ApplicationService
  HMAC_SECRET = 'myK3y$ecr3t'
  ALGORITHM_TYPE = 'HS256'

  def self.call
    payload = {"test" => "test"}

    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end
end