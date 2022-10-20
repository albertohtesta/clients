# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class ResponsesController < ApiController
        def index
          @survey_responses = TypeFormService::Responses.new
          render json: @survey_responses.all(params[:survey_id])
        end

        def show
          @survey_responses = TypeFormService::Responses.new
          render json: @survey_responses.insights(params[:survey_id])
        end
      end
    end
  end
end
