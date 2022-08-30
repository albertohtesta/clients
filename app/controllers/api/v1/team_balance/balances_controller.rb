# frozen_string_literal: true

module Api
  module V1
    module TeamBalance
      class BalancesController < ApplicationController
        def index
          render json: { message: "No balance found" }, status: :not_found
        end

        private
          def retrieve_team
            @team = TeamRepository.find_by(id: params[:team_id])
          end

          def balance_by_team_id
            TeamBalanceRepository.retrieve_team_by_id(@team.id) if @team
          end
      end
    end
  end
end
