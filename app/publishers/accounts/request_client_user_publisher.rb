
# frozen_string_literal: true

module Accounts
  class RequestClientUserPublisher < ApplicationPublisher
    direct_to "clients.client_user.request"
  end
end
