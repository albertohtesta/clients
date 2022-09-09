# frozen_string_literal: true

module Accounts
  class ClientUserFailedSubscriber < ApplicationSubscriber
    from_queue "core.client_user.failed"

    ATTRS = {
      message: :message
    }.freeze

    def process
      Rollbar.error("FAIL CLIENT CREATION", error_message: permitted_attributes[:message])
      puts permitted_attributes[:message]
    end
  end
end
