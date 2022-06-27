# frozen_string_literal: true

require "jwt"

module JsonWebToken
  extend ActiveSupport::Concern
  ALGORITHM_TYPE = "HS256"
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.jwt_encode(payload, exp = 7.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end

  def self.jwt_decode(token)
    decoded = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new decoded
  end
end
