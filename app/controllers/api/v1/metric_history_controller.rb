# frozen_string_literal: true

module Api
  module  V1
    class MetricHistoryController < ApplicationController
      before_action :retrive_metric, only: :show

      def show
        if @metric
          render json: MetricFollowUpPresenter.new(@metric).json
        else
          render json: { error: "Metric not found" }, status: :not_found
        end
      end

      def update
        @data = metric_historial_params
        if @data.permitted?
          MetricFollowUpRepository.update_historial(
            id: @data[:id],
            alert_status: @data[:alert_status],
            mitigation_strategy: @data[:mitigation_strategy],
            manager_id: @data[:manager_id]
          )

          return render json: { message: "Metric updated" }, status: :ok
        end

        render json: { error: "Metric not found" }, status: :not_found
      end

      private
        def retrive_metric
          @metric = MetricFollowUpRepository.find_by(id: params[:id])
        end

        def metric_historial_params
          params.permit(:id, :manager_id, :alert_status, :mitigation_strategy)
        end
    end
  end
end
