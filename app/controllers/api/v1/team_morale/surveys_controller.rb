# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class SurveysController < ApiController
        before_action :survey_by_id, only: %i[show destroy]

        def index
          @surveys = SurveyRepository.all
          render json: @surveys
        end

        def create
          @survey = Survey.new(survey_params)
          if SurveyRepository.save(@survey)
            SurveyCreateService.create_job(@survey)
            SurveySenderJob.perform_later @survey.id
            render json: SurveyPresenter.new(@survey).json, status: :ok
          else
            render json: { errors: survey.errors.full_messages }, status: :bad_request
          end
        end

        def show
          survey_responses = TypeFormService::Responses.new
          tf_current_answers = survey_responses.all(@survey.remote_survey_id)[:total_items]
          SurveyRepository.update_current_answers(@survey.id, tf_current_answers) unless @survey.current_answers == tf_current_answers
          render json: SurveyPresenter.new(@survey.reload).json, status: :ok
        end

        def destroy
          if SurveyResponsesService.new(@survey.id).close_survey
            render json: true, status: :ok
          else
            render json: false, status: :bad_request
          end
        end

        private
          def survey
            @survey ||= Survey.new(survey_params.merge(status: "preparation"))
          end
          def survey_params
            params.require(:survey).permit(:team_id, :deadline, :period, :survey_url, :year, :status, :requested_answers,
                                           :remote_survey_id, :period_value, :description, :current_answers,
                                           { questions_detail: { questions: [:title, :category, :final_score] } })
          end

          def survey_by_id
            @survey = SurveyRepository.find(params[:id])
          end
      end
    end
  end
end
