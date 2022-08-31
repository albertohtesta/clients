# frozen_string_literal: true

module Api
  module V1
    module TeamBalance
      class BalancesController < ApplicationController
        before_action :retrieve_teams, only: :index
        def index
          render json: { message: "No balance found" }, status: :not_found if @teams.nil

          render json: TeamBalancePresenter.json_collection(@teams), status: :ok
        end

        private
          def retrieve_teams
            @teams = TeamBalanceRepository.all
          end
      end
    end
  end
end
