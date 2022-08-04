# frozen_string_literal: true

module Api
  module  V1
    module Teams
      class InvestmentsController < ApplicationController
        before_action :retrieve_team, only: :show

        def show
          if investments = retrieve_investments_by_team_id
            render json: { project_indicators: InvestmentPresenter.send("order_by_#{params[:order_by]}", investments) }
          else
            render json: { message: "No investments data found" }, status: :not_found
          end
        end

        private
          def retrieve_team
            @team = TeamRepository.find_by(id: params[:team_id])
          end

          def retrieve_investments_by_team_id
            InvestmentRepository.retrieve_current_year_investments_by_team_id(@team.id) if @team
          end
      end
    end
  end
end
