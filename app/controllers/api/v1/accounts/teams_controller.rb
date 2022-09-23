# frozen_string_literal: true

module Api
  module V1
    module Accounts
      class TeamsController < ApplicationController
        before_action :retrieve_teams

        def index
          return render json: { message: "teams not found" }, status: :not_found if @teams.empty?

          render json: TeamPresenter.json_collection(@teams), status: :ok
        end

        private
          def retrieve_teams
            @teams = TeamRepository.retrieve_teams(params[:account_id])
          end
      end
    end
  end
end
