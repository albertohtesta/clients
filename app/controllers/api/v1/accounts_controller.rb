# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApiController
      def index
        account = account_of_contact
        return render json: { message: "No account information" }, status: :not_found if account.nil?

        render json: AccountPresenter.new(account).json, status: :ok
      end

      def show; end

      private
        def account_of_contact
          AccountRepository.find_by(@current_user[:contact_uuid])
        end
    end
  end
end
