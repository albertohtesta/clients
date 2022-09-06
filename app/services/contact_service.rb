# frozen_string_literal: true

# Service to manage contacts in cognito
class ContactService < CognitoService
  attr_reader :error

  def logged_contact_email
    logged_user[:user_attributes].find { |x| x[:name] == "email" }[:value]
  end

  private
    def logged_user
      stub_get_user if Rails.env.test?
      CLIENT.get_user(access_token: @user_object[:token]).to_h
    rescue StandardError => e
      @error = e
      Rollbar.error(e, "error getting contact service")
      false
    end
end
