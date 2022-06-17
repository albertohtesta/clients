# frozen_string_literal: true

require "test_helper"

class AppConnectionTest < ActiveSupport::TestCase
  test "Api token generated should start with api_ word" do
    assert AppConnection.generate_token("api").start_with?("api_")
  end

  test "Secret token generated should start with secret_ word" do
    assert AppConnection.generate_token("secret").start_with?("secret_")
  end

  test "Tokens generated should be greater than 32 characters" do
    assert(AppConnection.generate_token("secret").size > 32)
  end

  test "Secret key should be saved encrypted" do
    tokens = AppConnection.generate_tokens
    app_connection = AppConnection.create(tokens.merge({ name: "test" }))

    assert BCrypt::Password.new(app_connection.secret_token_digest) == tokens[:secret_token]
  end

  test "token should be authenticated" do
    tokens = AppConnection.generate_tokens
    app_connection = AppConnection.create(tokens.merge({ name: "test" }))

    assert app_connection.authenticate(tokens[:secret_token])
  end
end
