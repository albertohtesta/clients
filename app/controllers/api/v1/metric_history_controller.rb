# frozen_string_literal: true

module Api
  module  V1
    class MetricHistoryController < ApplicationController
      before_action :retrive_metric, only: :show

      def show
        if @last_status
          render json: MetricHistoryPresenter.new(retrive_metric).json
        else
          render json: { error: "Metric not found" }, status: :not_found
        end
      end

      def update
        @data = metric_historial_params
        if @data.permitted?
          MetricHistoryRepository.update_historial(
            id: @data[:id],
            alert_status: @data[:alert_status],
            mitigation_strategy: @data[:mitigation_strategy]
          )

          return render json: { message: "Metric updated" }, status: :ok
        end

        render json: { error: "Metric not found" }, status: :not_found
      end

      private
        def retrive_metric
          @last_status = MetricHistoryRepository.last_status(params[:id])
        end

        def metric_historial_params
          params.permit(:id, :alert_status, :mitigation_strategy)
        end
    end
  end
end
