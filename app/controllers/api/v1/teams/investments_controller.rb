# frozen_string_literal: true

module Api
  module  V1
    module Teams
      class InvestmentsController < ApiController
        def index
          investments = InvestmentService.investments_by_team_for_period(params[:team_id], params[:order_by])
          if investments.blank?
            render json: { message: "No investments data found" }, status: :not_found and return
          end
          render json: InvestmentPresenter.send("order_by_#{params[:order_by]}", investments)
        end
      end
    end
  end
end
