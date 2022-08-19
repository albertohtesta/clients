# frozen_string_literal: true

module Api
  module V1
    class AccountController < ApplicationController
      before_action :set_account, only: %i[index show]
      def index
        return render json: { message: "Accounts not found" }, status: :not_found if @account.empty?

        render json: CollaboratorPresenter.json_collection(@accounts), status: :ok
      end

      def show
        return render json: { message: "Account not found" }, status: :not_found if @account.empty?
      end

      private
        def set_account
          @accounts = AccountRepository.by_manager(params[:manager_id])
        end
    end
  end
end
