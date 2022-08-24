# frozen_string_literal: true

module Accounts
  class ClientUserCreatedSubscriber < ApplicationSubscriber
    from_queue "core.client_user.created"

    ATTRS = {
      contact_uuid: :uuid,
      email: :email
    }.freeze

    def process
      ClientRegistrationService.save_client_user_created(
        permitted_attributes[:email],
        permitted_attributes[:contact_uuid]
      )
    end
  end
end
