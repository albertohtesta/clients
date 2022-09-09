# frozen_string_literal: true

# manage creation of new user type_client to core
class ClientRegistrationService < ApplicationService
  class << self
    def request_user_client(customer_email)
      Rollbar.info("Request client user with: ", email: customer_email)
      Accounts::RequestClientUserPublisher.publish(customer_email)
    end

    def save_client_user_created(email, contact_uuid)
      ContactRepository.assign_uuid_and_status_to_contact(email, contact_uuid)
    end
  end
end
