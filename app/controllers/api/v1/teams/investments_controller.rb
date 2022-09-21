# frozen_string_literal: true

module Api
  module  V1
    module Teams
      class InvestmentsController < ApplicationController
        before_action :validate_required_params

        def index
          investments = investments_of_team_of_this_year
          return render json: { message: "No investments data found" }, status: :not_found unless investments

          investments_formated = InvestmentPresenter.send("order_by_#{params[:group_by]}", investments)
          render json: { team_indicators: investments_formated }
        end

        private
          def investments_of_team_of_this_year
            InvestmentRepository.retrieve_current_year_investments_by_team_id(params[:team_id])
          end

          def validate_required_params
            params.require([:group_by])
          rescue ActionController::ParameterMissing
            render json: { message: "Parameters missing" }, status: :bad_request
          end
      end
    end
  end
end
