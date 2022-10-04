# frozen_string_literal: true

module Accounts
  class ClientUserCreatedSubscriber < ApplicationSubscriber
    from_queue "core.client_user.created"

    ATTRS = {
      uuid: :uuid,
      email: :email
    }.freeze

    def process
      Rollbar.info("SUCCESS CLIENT", email: permitted_attributes[:email], uuid: permitted_attributes[:uuid])
      ClientRegistrationService.save_client_user_created(
        permitted_attributes[:email],
        permitted_attributes[:uuid]
      )
    end
  end
end
