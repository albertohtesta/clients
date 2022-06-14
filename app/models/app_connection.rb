
class AppConnection < ApplicationRecord
  has_secure_password :secret_token

  def authenticate(secret_token)
    if BCrypt::Password.new(secret_token_digest) == secret_token
      self
    else
      nil
    end
  end

private
  def generate_tokens
    credentials = { api_token: generate_api_token, secret_token: generate_secret_token }
  end

  def self.generate_api_token
    "api_#{SecureRandom.urlsafe_base64(16)}"
  end

  def self.generate_secret_token
    "scr_#{SecureRandom.urlsafe_base64(16)}"
  end
end
