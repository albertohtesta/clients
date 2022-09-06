# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApiController
      def index
        account = account_of_contact
        return render json: { message: "No account information" }, status: :not_found if account.nil?

        render json: AccountInfoPresenter.new(account).json, status: :ok
      end

      private
        def account_of_contact
          Rollbar.error(@current_user, "Controller, currentuser") # loggin from rollbar
          contact = ContactRepository.find_by({ uuid: @current_user[:uuid] })
          AccountRepository.find_by({ id: contact.account_id })
        rescue => e
          Rollbar.error(e)
          nil
        end
    end
  end
end
