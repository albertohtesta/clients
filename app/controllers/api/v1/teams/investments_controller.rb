# frozen_string_literal: true

module Api
  module  V1
    module Teams
      class InvestmentsController < ApplicationController
        before_action :validate_required_params

        def index
          investments = InvestmentService.investments_by_team_for_period(params[:team_id], params[:group_by])

          return render json: { message: "No investments data found" }, status: :not_found if investments.blank?

          render json: InvestmentPresenter.send("order_by_#{params[:group_by]}", investments)
        end

        private
          def investments_of_team_of_this_year
            InvestmentRepository.retrieve_previous_months_by_team(params[:team_id], Date.current.beginning_of_year, Date.current.end_of_year)
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
