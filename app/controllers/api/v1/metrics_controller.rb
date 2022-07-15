# frozen_string_literal: true

module Api
  module  V1
    class MetricsController < ApplicationController
      before_action :set_metric, only: %i[ index ]

      def index
        if @metrics
          render json: MetricPresenter.new(@metrics).json
        else
          render json: {}, status: :not_found
        end
      end

      private
        def set_metric
          @metrics = MetricRepository.get_metrics_per_project(from_date, to_date, metric_params)
        end

        def metric_params
          params.permit([:project_id, :group_by, :indicator_type])
        end

        def from_date
          params.require(:from_date)
        end

        def to_date
          params.require(:to_date)
        end
    end
  end
end
