# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApiController
      def index
        return render json: { message: "Accounts not found" }, status: :not_found if @accounts.nil?

        render json: AccountPresenter.json_collection(@accounts), status: :ok
      end

      def show
        return render json: { message: "Accounts not found" }, status: :not_found if @account.nil?

        render json: AccountPresenter.new(@account).json, status: :ok
      end
    end
  end
end
