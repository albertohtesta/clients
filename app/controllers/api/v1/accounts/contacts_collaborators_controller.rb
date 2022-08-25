# frozen_string_literal: true

module Api
  module V1
    module Accounts
      class ContactsCollaboratorsController < ApplicationController
        before_action :retrieve_contacts, only: :index

        def index
          return render json: { message: "Contacts not found" }, status: :not_found if @account_info.empty?

          render json: AccountContactCollaboratorPresenter.json_collection(@account_info), status: :ok
        end

        private
          def retrieve_contacts
            @account_info = AccountContactCollaboratorRepository.contacts_by_account(params[:account_id])
          end
      end
    end
  end
end