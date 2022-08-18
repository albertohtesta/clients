# frozen_string_literal: true

module Api
  module  V1
    module Managers
      class AccountsController < ApplicationController
        def index
          accounts = ManagerAccountsPresenter.json_collection(accounts_by_managger)

          render json: accounts, status: :ok
        end

        private
          def accounts_by_managger
            AccountRepository.by_manager(params[:manager_id])
          end
      end
    end
  end
end