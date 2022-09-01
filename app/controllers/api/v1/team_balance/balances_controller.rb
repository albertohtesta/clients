# frozen_string_literal: true

module Api
  module V1
    module TeamBalance
      class BalancesController < ApplicationController
        before_action :retrieve_teams, only: :index
        def index
          render json: { message: "No balance found" }, status: :not_found if  @team_balances.nil

          render json: TeamBalancePresenter.json_collection(@team_balances), status: :ok
        end


        private
          def set_team_balance
            @team_balances = TeamBalanceService.new(params[:team_id]).create
          end
      end
    end
  end
end
