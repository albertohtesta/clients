# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class RemoteSurveysController < ApplicationController
        def index
          render json: TypeFormService::RemoteSurveys.all
        end

        def show
          render json: TypeFormService::RemoteSurveys.survey_url_by_form_id(params[:id])
        end

        def update
          options = { op: params[:op], path: params[:path], value: params[:value] }
          render json: TypeFormService::RemoteSurveys.update(params[:id], options)
        end

        def create
          render json: TypeFormService::RemoteSurveys.create
        end
      end
    end
  end
end
