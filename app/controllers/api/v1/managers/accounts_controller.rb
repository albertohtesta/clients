# frozen_string_literal: true

module Api
  module  V1
    module Managers
      class AccountsController < ApiController
        def index
          return render json: ManagerAccountsPresenter.json_collection(AccountRepository.all), status: :ok if params[:filter] == "all"

          render json: ManagerAccountsPresenter.json_collection(accounts_by_managger), status: :ok
        end

        private
          def accounts_by_managger
            AccountRepository.by_manager(params[:manager_id])
          end
      end
    end
  end
end
