# frozen_string_literal: true

module Api
  module V1
    module TeamBalance
      class BalancesController < ApplicationController
        before_action :retrieve_teams, only: :index
        before_action :retrieve_team_by_id, only: :create
        def index
          render json: { message: "No balance found" }, status: :not_found if @teams.nil

          render json: TeamBalancePresenter.json_collection(@teams), status: :ok
        end

        # def create
        #   balance = TeamBalanceService.new(team_id).process

        #   if balance.save
        #     render json: { message: "balance save to the database" }, status: :ok
        #   else
        #     render json: { error: balance.errors.full_messages }, status: :unprocessable_entity
        #   end
        # end

        private
          def retrieve_teams
            @teams = TeamBalanceRepository.all
          end

          def retrieve_team_by_id
            @team = TeamBalanceRepository.balance_by_team(param[:team_id])
          end

          def team_balance_params
            params.require(:team_balance).permit(:team_id, :balance, :balance_date)
          end
      end
    end
  end
end
