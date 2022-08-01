# frozen_string_literal: true

module Api
  module V1
    class ContactsController < ApiController
      before_action :retrieve_contacts, only: %i[index]

      def index
        return render json: { message: "Contacts not found" }, status: :not_found if @account_info.empty?

        render json: ContactPresenter.json_collection(@account_info), status: :ok
      end

      def retrieve_contacts
        @account_info = ContactRepository.contacts_by_account(params[:account_id])
      end
    end
  end
end
