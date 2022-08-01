# frozen_string_literal: true

# Service to manage collaborators in cognito
class CollaboratorService < CognitoService
  attr_reader :error

  def logged_user_email
    logged_user[:collaborator_attributes].find { |x| x[:name] == "email" }[:value]
  end

  private

  def logged_user
    stub_get_user if Rails.env.test?
    CLIENT.get_user(access_token: @user_object[:token]).to_h
  rescue StandardError => e
    @error = e
    false
  end
end
