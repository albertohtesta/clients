# frozen_string_literal: true

module Api
  module  V1
    class MetricsController < ApplicationController
      before_action :validate_required_params, :set_metric, only: %i[ index ]

      def index
        if @metrics
          render json: { team_indicators: @metrics }
        else
          render json: { message: "Not metrics found" }, status: :not_found
        end
      end

      private
        def set_metric
          @metrics = PresenterMetricService.new(params[:group_by], metrics_filters).present
        end

        def metrics_filters
          params.permit([:team_id, :indicator_type])
        end

        def validate_required_params
          params.require([:group_by, :indicator_type, :team_id])
        rescue ActionController::ParameterMissing
          render json: { message: "Parameters missing" }, status: :bad_request
        end
    end
  end
end
