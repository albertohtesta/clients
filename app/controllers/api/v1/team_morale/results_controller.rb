# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      # results controller
      class ResultsController < ApplicationController
        def index
          surveys = SurveyResultsService.get_surveys(params[:initial_month], params[:end_month], params[:year],
                    params[:team_id], params[:type])
          return render json: { message: "No surveys found within this search criteria.", status: :not_found } if surveys.empty?

          render json: surveys, status: :ok
        end
      end
    end
  end
end
