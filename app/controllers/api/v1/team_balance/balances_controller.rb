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

        def create
          @team_balance = @team.TeamBalanceRepository.new_entity(team_balance_params)

          if @team_balance.save
            render json: @team_balance, status: :created
          else
            render json: @team_balance, status: :unprocessable_entity
          end
        end

        private
          def retrieve_teams
            @teams = TeamBalanceRepository.all
          end

          def retrieve_team_by_id
            @team = TeamBalanceRepository.balance_by_team(param[:team_id])
          end

          def team_balance_params
            params.permit(:team_id, :balance, :balance_date)
          end
      end
    end
  end
end
