# frozen_string_literal: true

require "test_helper"

class AppConnectionTest < ActiveSupport::TestCase
  setup do
    @tokens = AppConnection.generate_tokens
  end
  test "Should generat api_name" do
    assert @tokens[:api_name]
  end

  test "Should generat secret_token" do
    assert @tokens[:secret_token]
  end

  test "Tokens generated should be greater than 32 characters" do
    assert(@tokens[:api_name].size > 32)
  end

  test "Secret key should be saved encrypted" do
    app_connection = AppConnection.create(@tokens.merge({ name: "test" }))
    assert BCrypt::Password.new(app_connection.secret_token_digest) == @tokens[:secret_token]
  end

  test "token should be authenticated" do
    app_connection = AppConnection.create(@tokens.merge({ name: "test" }))
    assert app_connection.authenticate(@tokens[:secret_token])
  end
end
