
# frozen_string_literal: true

module Accounts
  class RequestClientUserPublisher < ApplicationPublisher
    direct_to "core.client_user.new"
  end
end
