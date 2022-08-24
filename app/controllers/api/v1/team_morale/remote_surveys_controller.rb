# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class RemoteSurveysController < ApplicationController
        def index
          @surveys = TypeFormService::RemoteSurveys.new
          render json: @surveys.all
        end

        def show
          @surveys = TypeFormService::RemoteSurveys.new
          render json: @surveys.survey_url(params[:id])
        end

        def update
          @surveys = TypeFormService::RemoteSurveys.new
          options = { op: params[:op], path: params[:path], value: params[:value] }
          render json: @surveys.update(params[:id], options)
        end

        def create
          @surveys = TypeFormService::RemoteSurveys.new
          render json: @surveys.create
        end
      end
    end
  end
end
