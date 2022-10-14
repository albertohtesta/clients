# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class WebhooksController < ApiController
        def index
          @webhooks = TypeFormService::Webhooks.new
          render json: @webhooks.all(params[:survey_id])
        end

        def create
          @webhooks = TypeFormService::Webhooks.new
          options = { enabled: true, url: "my.endpoint.com" }
          render json: @webhooks.update!(params[:survey_id], params[:webhook_tag], options)
        end

        def update
          @webhooks = TypeFormService::Webhooks.new
          options = { enabled: true, url: "my.endpoint.com" }
          render json: @webhooks.update!(params[:survey_id], params[:webhook_tag], options)
        end

        def show
          @webhooks = TypeFormService::Webhooks.new
          render json: @webhooks.find(params[:survey_id], params[:webhook_tag])
        end
      end
    end
  end
end
