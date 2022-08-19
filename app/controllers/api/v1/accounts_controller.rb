# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApiController
      before_action :accounts_by_managers, only: :index
      def index
        return render json: { message: "Accounts not found" }, status: :not_found if @accounts.empty?

        render json: AccountPresenter.json_collection(@accounts), status: :ok
      end

      private
        def accounts_by_managers
          @accounts = AccountRepository.by_manager(params[:manager_id])
        end
    end
  end
end
