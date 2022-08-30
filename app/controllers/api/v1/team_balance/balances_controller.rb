# frozen_string_literal: true

module Api
  module V1
    module TeamBalance
      class BalancesController < ApplicationController
        before_action :balance_by_team_id, only: :index
        def index
          render json: { message: "No balance found" }, status: :not_found if @team.nil
        end

        private
          def balance_by_team_id
            @team = TeamBalanceRepository.retrieve_team_by_id(@team.id)
          end
      end
    end
  end
end
