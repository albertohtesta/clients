# frozen_string_literal: true

module Api
  module V1
    class AccountController < ApplicationController
      before_action :retrieve_contacts, only: %i[index show]
      def index
        return render json: { message: "Accounts not found" }, status: :not_found if @account_info.empty?
      end

      def show
        return render json: { message: "Accounts not found" }, status: :not_found if @account_info.empty?
      end

      private
        def retrieve_contacts
          @account_info = AccountContactCollaboratorRepository.contacts_by_account(params[:account_id])
        end
    end
  end
end
