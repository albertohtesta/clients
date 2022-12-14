# frozen_string_literal: true

# create cognito client
class CognitoService < ApplicationService
  CLIENT = Aws::CognitoIdentityProvider::Client.new(
    region: ENV.fetch("AWS_REGION", "local"),
    access_key_id: ENV.fetch("COGNITO_ADMIN_ACCESS_KEY", "local"),
    secret_access_key: ENV.fetch("COGNITO_ADMIN_SECRET_KEY", "local"),
    stub_responses: Rails.env.test?
  ).freeze

  CLIENT_ID = ENV.fetch("AWS_COGNITO_USER_POOL_CLIENT_ID", "local").freeze
  POOL_ID = ENV.fetch("AWS_COGNITO_USER_POOL", "local").freeze

  def initialize(user_object)
    @user_object = user_object
  end

  private
    def stub_get_user
      CLIENT.stub_responses(:get_user, {
        username: Contact.last.uuid,
        user_attributes: [
                          { name: "sub", value: Contact.last.uuid },
                          { name: "email_verified", value: "true" },
                          { name: "email", value: Contact.last.email }
                        ]
      })
    end
end
