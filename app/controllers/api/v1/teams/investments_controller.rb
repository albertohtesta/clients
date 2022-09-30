# frozen_string_literal: true

module Api
  module  V1
    module Teams
      class InvestmentsController < ApplicationController
        before_action :validate_required_params

        def index
          investments = investments_of_team_of_this_year
          return render json: { message: "No investments data found" }, status: :not_found if investments.empty?

          investments_formated = InvestmentPresenter.send("order_by_#{params[:group_by]}", investments)
          render json: investments_formated
        end

        private
          def investments_of_team_of_this_year
            InvestmentService.investments_by_team_for_period(params[:team_id], params[:group_by])
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
