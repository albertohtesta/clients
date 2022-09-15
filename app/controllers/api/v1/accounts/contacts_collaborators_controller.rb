# frozen_string_literal: true

module Api
  module V1
    module Accounts
      class ContactsCollaboratorsController < ApiController
        def index
          contacts_collabs = retrieve_contacts
          return render json: { message: "Contacts not found" }, status: :not_found if contacts_collabs.empty?

          render json: AccountContactCollaboratorPresenter.json_collection(contacts_collabs), status: :ok
        end

        private
          def retrieve_contacts
            AccountContactCollaboratorRepository.contacts_by_account(params[:account_id])
          end
      end
    end
  end
end
