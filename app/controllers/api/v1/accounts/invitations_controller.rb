# frozen_string_literal: true

module Api
  module V1
    module Accounts
      class InvitationsController < ApiController
        def create
          contacts_emails.each do |email|
            ClientRegistrationService.request_user_client({ email: })
          end
          ContactRepository.create_invitations_for(params[:account_id], contacts_emails)

          render json: {}, status: :ok
        end

        private
          def contacts_emails
            @contacts_emails ||= ContactRepository.create_or_get_contacts_by_account(params[:account_id], invitated_contacts[:contacts])
          end

          def invitated_contacts
            params.permit(contacts: [:email, :first_name, :last_name])
          rescue ActionController::ParameterMissing
            render json: { message: "Parameters missing" }, status: :bad_request
          end
      end
    end
  end
end
