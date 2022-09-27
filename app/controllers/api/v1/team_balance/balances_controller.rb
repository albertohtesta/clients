# frozen_string_literal: true

module Api
  module V1
    module TeamBalance
      class BalancesController < ApiController
        before_action :retrieve_teams, only: :index

        def index
          render json: { message: "No balance found" }, status: :not_found if  @teams.nil?

          render json: TeamBalancePresenter.json_collection(@teams), status: :ok
        end

        def create
          @team_balance = TeamBalanceRepository.new_entity(team_balance_params)

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

          def team_balance_params
            params.permit(:team_id, :balance, :balance_date)
          end
      end
    end
  end
end
