# frozen_string_literal: true

class AppConnection < ApplicationRecord
  has_secure_password :secret_token

  def authenticate(secret_token)
    self if BCrypt::Password.new(secret_token_digest) == secret_token
  end

  def self.generate_tokens
    { api_token: generate_token("api"), secret_token: generate_token("secret") }
  end

  def self.generate_token(type)
    "#{type}_#{SecureRandom.hex}"
  end

end