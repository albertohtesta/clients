# frozen_string_literal: true

module Api
  module V1
    module Accounts
      class ContactsController < ApiController
        def index
          return render json: { message: "Contacts not found" }, status: :not_found if contacts.empty?

          render json: AccountContactPresenter.json_collection(contacts), status: :ok
        end

        def show
          return render json: { message: "Contacts not found" }, status: :not_found if contact.nil?

          render json: AccountContactPresenter.new(contact).json, status: :ok
        end

        private
          def contacts
            @contacts ||= ContactRepository.contacts_by_account(params[:account_id])
          end

          def contact
            @contact ||= ContactRepository.find_by(id: params[:id], account_id: params[:account_id])
          end
      end
    end
  end
end
