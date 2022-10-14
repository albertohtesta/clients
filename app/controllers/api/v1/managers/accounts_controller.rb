# frozen_string_literal: true

module Api
  module  V1
    module Managers
      class AccountsController < ApiController
        def index
          accounts = ManagerAccountsPresenter.json_collection(accounts_by_managger)

          render json: accounts, status: :ok
        end

        def as_admin
          # rubocop:disable Lint/RequireParentheses
          return render json: { message: "No account information" }, status: :not_found if current_user.instance_of? Contact || current_user.role.name != "ADMIN"
          # rubocop:enable Lint/RequireParentheses
          accounts = ManagerAccountsPresenter.json_collection(AccountRepository.all)

          render json: accounts, status: :ok
        end

        private
          def accounts_by_managger
            AccountRepository.by_manager(retrive_manager_id)
          end

          def retrive_manager_id
            return @retrive_manager_id ||= current_user.account.manager_id if current_user.instance_of? Contact

            @retrive_manager_id ||= current_user.id
          end
      end
    end
  end
end
