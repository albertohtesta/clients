# frozen_string_literal: true

module Api
  module V1
    module Accounts
      class InvitationsController < ApplicationController
        def create
          invited = []
          get_contacts_from_account.each do |contact|
            invited << InviteAccountContactsMailer.invite_to(name: contact[:first_name], email: contact[:email], link: get_invitation_link)
          end
          ContactRepository.create_invitations_for(params[:account_id], invitated_contacts)

          render json: { succes: invited.flatten.join(" ") }, status: :ok
        end

        private
          def invitated_contacts
            params.require(:emails)
          end

          def get_contacts_from_account
            ContactRepository.contacts_by_account_and_email(params[:account_id], invitated_contacts)
          end

          # TODO: this links is just temporal, redirect to register login instead
          def get_invitation_link
            account = AccountRepository.account_project_by_account_id(params[:account_id])
            "#{account.id}/#{account.projects[0].id}/#{account.projects[0].teams[0].id}"
          end
      end
    end
  end
end
