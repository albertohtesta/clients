# frozen_string_literal: true

class AppConnection < ApplicationRecord
  has_secure_password :secret_token

  def authenticate(secret_token)
    self if BCrypt::Password.new(secret_token_digest) == secret_token
  end

  class << self
    def generate_tokens
      { api_name: generate_api_name, secret_token: generate_secret_token }
    end

    private

    def generate_api_name(name = nil)
      app_connection = AppConnection.where(api_name: name).first
      name = generate_api_name("api_#{SecureRandom.hex}") if name.nil? || app_connection
      name
    end

    def generate_secret_token
      "secret_#{SecureRandom.urlsafe_base64}"
    end
  end
end
