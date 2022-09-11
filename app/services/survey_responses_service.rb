# frozen_string_literal: true

class SurveyResponsesService < ApplicationService
  attr_reader :survey_id

  def initialize(survey_id)
    @survey ||= Survey.find_by_id(survey_id)
  end

  def get_responses
    return unless @survey.remote_survey_id.present?
    surveys = get_remote_responses(@survey.remote_survey_id)
    questions = get_questions(surveys)
    questions = calculate_questions_average(questions, surveys.length)
    @survey.questions_detail = get_questions_detail(questions)
    @survey.save
  end

  def close_survey
    return unless survey_should_be_closed
    close_remote_survey unless @survey.remote_survey_id.blank?
    @survey.reload.status = 2
    @survey.save
  end

  private
    def survey_should_be_closed
      @survey.present? && @survey.status != 2 && ((@survey.current_answers >= @survey.requested_answers) || @survey.deadline < Date.today)
    end

    def close_remote_survey
      get_responses unless @survey.remote_survey_id.nil?
      TypeFormService::RemoteSurveys.update(@survey.remote_survey_id, { "op": "replace", "path": "/settings/is_public", "value": false })
    end

    def get_remote_responses(remote_survey_id)
      survey_responses = TypeFormService::Responses.new
      survey_responses.all(remote_survey_id)[:items]
    end

    def get_questions(surveys)
      questions = {}
      surveys.each do |survey|
        variables = survey[:variables]
        variables.each do |var|
          key = var[:key]
          survey_question = SurveyQuestion.find_by(question: key)
          if survey_question.present?
            questions.key?(key) ? questions[key] += var[:number] : questions[key] = var[:number]
          end
        end
      end
      questions
    end

    def calculate_questions_average(questions, surveys_length)
      questions.transform_values { |v| v / surveys_length }
    end

    def get_questions_detail(questions)
      questions_detail = questions.map do |key, value|
        question = SurveyQuestion.find_by(question: key)
        { "title": key,
          "category": question.morale_attribute.name,
          "final_score": value }
      end
      { questions: questions_detail }
    end
end
