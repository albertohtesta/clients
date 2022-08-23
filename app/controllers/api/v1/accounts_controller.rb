# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApiController
      before_action :retrieve_accounts, only: :index
      before_action :find_account, only: :show
      def index
        return render json: { message: "Accounts not found" }, status: :not_found if @accounts.nil?

        render json: AccountPresenter.json_collection(@accounts), status: :ok
      end

      def show
        return render json: { message: "Accounts not found" }, status: :not_found if @account.nil?

        render json: AccountPresenter.new(@account).json, status: :ok
      end

      private
        def retrieve_accounts
          @accounts = AccountRepository.by_account
        end

        def find_account
          @account = AccountRepository.retrieve_accounts_by_id(id: params[:id])
        end
    end
  end
end
