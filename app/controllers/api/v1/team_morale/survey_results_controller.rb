# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class SurveyResultsController < ApplicationController
        def index
          results = SurveyResultsService.get_surveys(params[:initial_month], params[:end_month], params[:year],
                    params[:team_id])
          render json: results, status: :ok
        end
      end
    end
  end
end
