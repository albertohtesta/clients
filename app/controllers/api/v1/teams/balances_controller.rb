# frozen_string_literal: true

module Api
  module V1
    module Teams
      class BalancesController < ApplicationController
        def create
          @team_balance = TeamBalanceRepository.new_entity(account_follow_ups_params)

          if @team_balance.save
            render json: @team_balance, status: :created
          else
            render json: @team_balance, status: :unprocessable_entity
          end
        end

        private
          def team_balance_params
            params.require(:team_balance).permit(:team_id, :account_id, :balance, :balance_date)
          end
      end
    end
  end
end
