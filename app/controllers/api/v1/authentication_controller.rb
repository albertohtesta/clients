# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      def create
        @account = AccountContactCollaboratorRepository.contacts_by_account(params[:account_id])

        if !@account
          render json: { message: "Invalid account" }, status: :unprocessable_entity
        else
          @account.authenticate(params[:name])
          token = JWT.encode({
            account_id: @account.id,
            account_account_uuid: @account.account_uuid,
            accounnt_name: @account.name,
            account_contact_email: @account.contact_email
          })

          render json: {
            token:,
            account_account_uuid: @account.account_uuid,
            name: @account.name,
            account_contact_email: @account.contact_email
            }, status: :Ok
        end
      end
    end
  end
end
