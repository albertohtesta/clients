# frozen_string_literal: true

class MetricFollowUpRepository < ApplicationRepository
  class << self
    def mitigation_strategy(id)
      scope.find_by(id:).mitigation_strategy
    end

    def add_follow_up(**args)
      input = params(args)
      follow_up = scope.where(
        account_id: input[:account_id],
        follow_date: Date.today,
        metric_type: input[:metric_type],
        manager_id: input[:manager_id]
      ).first_or_initialize
      follow_up.update!(alert_status: args[:alert_status],
        mitigation_strategy: args[:mitigation_strategy])
    end

    private
      def params(args)
        throw ArgumentError.new("Invalid params (No Id or Metric Type was sent).") if !args[:id] && !args[:metric_type]

        params = {}
        if args[:id]
          metric = MetricRepository.find_by(id: args[:id])
          throw ArgumentError.new("Metric was not found by id(#{args[:id]})") unless metric

          params[:metric_type] = metric.indicator_type
          if metric.related.instance_of?(Account)
            params[:account_id] = metric.related.id
            params[:manager_id] = metric.related.manager_id
          end
        end
        params[:metric_type] ||= args[:metric_type]
        params[:account_id] ||= args[:account_id].to_i
        throw ArgumentError.new("Account was not found (Id nor Account Id") unless params[:account_id]

        params[:manager_id] ||= args[:manager_id].to_i
        params[:manager_id] = AccountRepository.find_by(id: params[:account_id]).manager_id if params[:manager_id].to_i == 0
        params
      end
  end
end
