# frozen_string_literal: true

module Api
  module  V1
    module Teams
      class InvestmentsController < ApiController
        before_action :validate_required_params
        def index
          investments = InvestmentService.investments_by_team_for_period(params[:team_id], params[:group_by])
          return render json: { message: "No investments data found" }, status: :not_found if investments.blank?
          render json: InvestmentPresenter.send("group_by_#{params[:group_by]}", investments)
        end

        private
          def validate_required_params
            params.require([:group_by, :team_id])
          rescue ActionController::ParameterMissing
            render json: { message: "Parameters missing" }, status: :bad_request
          end
      end
    end
  end
end
