# frozen_string_literal: true

class SurveyResponsesService < ApplicationService
  attr_accessor :surveys

  def initialize(surveys)
    @surveys = surveys
  end

  def self.get_responses(remote_survey_id)
    survey_responses = TypeFormService::Responses.new
    data = survey_responses.all(remote_survey_id)
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
    survey = Survey.find_by(remote_survey_id:)
    survey.questions_detail = questions_detail
    survey.status = 2
    options = { "op": "replace", "path": "/settings/is_public", "value": false }
    TypeFormService::RemoteSurveys.update(remote_survey_id, options)
    survey.save
  end

  def self.calculate_started_at(period, period_value, year)
    case period
    when 0
      "01/#{period_value}/#{year}".to_date
    when 1
      date_for_quarter(period_value, year)
    else
      "01/01/#{year}".to_date
    end
  end

  def self.date_for_quarter(value, year)
    case value
    when 1
      "01/01/#{year}".to_date
    when 2
      "01/04/#{year}".to_date
    when 3
      "01/07/#{year}".to_date
    when 4
      "01/10/#{year}".to_date
    end
  end
end
