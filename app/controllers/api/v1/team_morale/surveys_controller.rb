# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class SurveysController < ApplicationController
        def index
          @surveys = SurveyMonkeyService::Surveys.new
          render json: @surveys.all
        end

        def show
          @surveys = SurveyMonkeyService::Surveys.new
          render json: @surveys.find_with_details(params[:id])
        end
      end
    end
  end
end
