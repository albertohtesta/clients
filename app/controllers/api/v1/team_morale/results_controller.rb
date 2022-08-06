# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      # results controller
      class ResultsController < ApplicationController
        
        def index
          surveys = make_response
          return render json: { message: "No surveys found within this search criteria.", status: :not_found } if surveys.empty?

          render json: surveys, status: :ok
        end

        private

        def make_response
          surveys = SurveyRepository.surveys_by_team_dates_status(params[:team_id], 
                    Date.parse(params[:initial_date]), Date.parse(params[:end_date]), 1)
          if !surveys.empty?
            survey_result_service = SurveyResultsService.new(surveys)
            surveys = survey_result_service.convert_to_array(params[:type] == 'detail'? true: false)        
            surveys = survey_result_service.calc_average(surveys) if params[:type] == 'global'
            surveys
          else
            surveys
          end
        end

      end

    end
  end
end
