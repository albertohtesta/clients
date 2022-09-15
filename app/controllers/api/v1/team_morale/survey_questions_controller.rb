# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class SurveyQuestionsController < ApplicationController
        def index
          @survey_questions = SurveyQuestion.all
          render json: @survey_questions
        end
      end
    end
  end
end
