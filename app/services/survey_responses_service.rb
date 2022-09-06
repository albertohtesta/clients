# frozen_string_literal: true

class SurveyResponsesService < ApplicationService
  attr_accessor :surveys

  def initialize(surveys)
    @surveys = surveys
  end

  def self.get_responses(survey)
    survey_responses = TypeFormService::Responses.new
    data = survey_responses.all(survey.remote_survey_id)
    questions = {}
    surveys = data[:items]
    surveys.each do |survey|
      variables = survey[:variables]
      variables.each do |var|
        key = var[:key]
        survey_question = SurveyQuestion.find_by(question: key)
        if survey_question.present?
          if questions.key?(key)
            questions[key] += var[:number]
          else
            questions[key] = var[:number]
          end
        end
      end
    end
    questions.each do |key, value|
      questions[key] = value / surveys.length
    end
    questions

    questions_detail = questions.map do |key, value|
      question = SurveyQuestion.find_by(question: key)
      { "title": key,
       "category": question.morale_attribute.name,
       "final_score": value }
    end
    questions_detail = { questions: questions_detail }
    survey.questions_detail = questions_detail
    survey.save
  end

  def self.close_survey(survey_id)
    survey = Survey.find(survey_id)
    return unless survey.present? && survey.status != 2
    get_responses(survey)
    survey.status = 2
    options = { "op": "replace", "path": "/settings/is_public", "value": false }
    TypeFormService::RemoteSurveys.update(survey.remote_survey_id, options)
    survey.save
  end
end
