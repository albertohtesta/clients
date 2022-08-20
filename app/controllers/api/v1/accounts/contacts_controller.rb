# frozen_string_literal: true

module Api
  module V1
    module Accounts
      class ContactsController < ApplicationController
        before_action :retrieve_contacts, only: :index

        def index
          return render json: { message: "Contacts not found" }, status: :not_found if @contacts.empty?

          render json: AccountContactPresenter.json_collection(@contacts), status: :ok
        end

        private
          def retrieve_contacts
            @contacts = ContactRepository.contacts_by_account(params[:account_id])
          end
      end
    end
  end
end
