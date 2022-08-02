# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class ResponsesController < ApplicationController
        def index
          @client = SurveyMonkeyService::Client.new
          render json: @client.responses(params[:survey_id])
        end

        def show
          @client = SurveyMonkeyService::Client.new
          render json: @client.response_with_details(params[:survey_id], params[:id])
        end
      end
    end
  end
end
