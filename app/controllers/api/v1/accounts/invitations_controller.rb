# frozen_string_literal: true

module Api
  module V1
    module Accounts
      class InvitationsController < ApplicationController
        def create
          get_contacts_from_account.each do |contact|
            ClientRegistrationService.request_user_client(contact)
          end
          ContactRepository.create_invitations_for(params[:account_id], invitated_contacts)

          render json: {}, status: :ok
        end

        private
          def invitated_contacts
            params.require(:emails)
          end

          def get_contacts_from_account
            ContactRepository.contacts_by_account_and_email(params[:account_id], invitated_contacts)
          end
      end
    end
  end
end
