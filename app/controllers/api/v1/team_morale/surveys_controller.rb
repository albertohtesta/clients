# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class SurveysController < ApplicationController
        before_action :survey_by_id, only: %i[show destroy]
        before_action :validate_required_params, :validate_period, :validate_period_value, only: %i[ create ]

        def index
          @surveys = SurveyRepository.all
          render json: @surveys
        end

        def create
          @survey = Survey.new(survey_params)
          if SurveyRepository.save(@survey)
            create_jobs
            render json: SurveyPresenter.new(@survey).json, status: :ok
          else
            render json: { errors: survey.errors.full_messages }, status: :bad_request
          end
        end

        def show
          check_status
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

          def check_status
            return unless @survey.status != "closed"

            if @survey.remote_survey_id.present?
              survey_responses = TypeFormService::Responses.new.all(@survey.remote_survey_id)
              unless survey_responses.blank?
                tf_current_answers = survey_responses[:total_items]
                SurveyRepository.update_current_answers(@survey.id, tf_current_answers) unless @survey.current_answers == tf_current_answers
              end
            end
            SurveyResponsesService.new(@survey.id).close_survey
          end

          def validate_required_params
            params.require([:period, :year, :team_id, :period_value])
            rescue ActionController::ParameterMissing
              render json: { message: "Parameters missing" }, status: :bad_request
          end

          def validate_period
            render json: { message: "Period invalid must be [month, quarter or year]" }, status: :bad_request unless ["month", "quarter", "year"].include?(params[:period])
          end

          def validate_period_value
            case params[:period]
            when "month"
              render json: { message: "Period invalid must be [1-12]" }, status: :bad_request unless (1..12).include?(params[:period_value])
            when "quarter"
              render json: { message: "Period invalid must be [1-4]" }, status: :bad_request unless (1..4).include?(params[:period_value].to_i)
            end
          end

          def create_jobs
            return unless @survey.status != "closed"

            SurveyCreateService.create_job(@survey)
            SurveySenderJob.perform_later @survey.id
          end
      end
    end
  end
end
