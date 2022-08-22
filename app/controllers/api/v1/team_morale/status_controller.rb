# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class StatusController < ApplicationController
        def index
          @survey = SurveyRepository.find_by_id(params[:survey_id])
          if @survey
            render json: StatusPresenter.new(@survey).json, status: :ok
          else
            render json: { message: "No survey data found" }, status: :not_found
          end
        end
      end
    end
  end
end
