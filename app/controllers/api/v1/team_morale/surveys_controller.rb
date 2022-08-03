# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class SurveysController < ApplicationController
        def index
          @surveys = TypeFormService::Surveys.new
          render json: @surveys.all
        end

        def show
          @surveys = TypeFormService::Surveys.new
          render json: @surveys.find(params[:id])
        end
      end
    end
  end
end
