# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class ResponsesController < ApplicationController
        def index
          @survey_responses = TypeFormService::SurveyResponses.new
          render json: @survey_responses.responses(params[:survey_id])
        end
      end
    end
  end
end
