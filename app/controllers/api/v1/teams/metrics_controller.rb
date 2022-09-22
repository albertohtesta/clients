# frozen_string_literal: true

module Api
  module  V1
    module  Teams
      class MetricsController < ApiController
        before_action :validate_required_params, only: %i[ index ]

        def index
          metrics = set_metric
          return render json: { message: "Not metrics found" }, status: :not_found unless metrics

          render json: { team_indicators: metrics }
        end

        private
          def set_metric
            @metrics = PresenterMetricService.new(params[:group_by], metrics_filters).present
          end

          def metrics_filters
            params.permit([:indicator_type]).merge({ related_type: "Team", related_id: params[:team_id] })
          end

          def validate_required_params
            params.require([:group_by, :indicator_type])
          rescue ActionController::ParameterMissing
            render json: { message: "Parameters missing" }, status: :bad_request
          end
      end
    end
  end
end
