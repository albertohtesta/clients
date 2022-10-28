# frozen_string_literal: true

class SurveyResponsesService < ApplicationService
  attr_reader :survey_id

  def initialize(survey_id)
    @survey ||= Survey.find_by_id(survey_id)
  end

  def close_survey
    return unless survey_should_be_closed?

    if @survey.update(status: :closed)
      close_remote_survey unless @survey.remote_survey_id.blank?
      true
    else
      false
    end
  end

  def self.average_of_last_survey_of_team(team_id)
    survey = SurveyRepository.last_survey_of_team(team_id)
    return unless survey && survey.questions

    survey.questions.inject(0) { |sum, element| sum + element["final_score"] } / survey.questions.length
  end

  def self.survey_status_updating(survey_id)
    survey = SurveyRepository.find_by_id(survey_id)
    return unless survey.present?
    remote_responses = number_of_remote_responses(survey.remote_survey_id) unless survey.remote_survey_id.blank?
    SurveyRepository.update_survey_responses(survey.id, remote_responses) unless remote_responses.blank?
    SurveyResponsesService.new(survey.id).close_survey unless survey.status == "closed"
  end

  def self.surveys_status_update
    SurveyRepository.surveys_ongoing.each { |survey| survey_status_updating(survey.id) }
  end

  private
    def survey_should_be_closed?
      @survey.present? && !@survey.closed? && completed_or_time_out?
    end

    def completed_or_time_out?
      @survey.current_answers >= @survey.requested_answers || @survey.deadline < Date.today
    end

    def close_remote_survey
      include_responses_in_survey unless !@survey.remote_survey_id
      TypeFormService::RemoteSurveys.update(@survey.remote_survey_id, { "op": "replace", "path": "/settings/is_public", "value": false })
    end

    def include_responses_in_survey
      responses = remote_responses(@survey.remote_survey_id)
      return unless @survey.remote_survey_id.present? && responses.length > 0

      questions = questions(responses)
      questions = calculate_questions_average(questions, responses.length)
      @survey.questions_detail = questions_detail(questions)
      @survey.save
    end

    def remote_responses(remote_survey_id)
      survey_responses = TypeFormService::Responses.new.all(remote_survey_id)
      return unless survey_responses
      survey_responses[:items]
    end

    def self.number_of_remote_responses(remote_survey_id)
      survey_responses = TypeFormService::Responses.new.all(remote_survey_id)
      return unless survey_responses
      survey_responses[:total_items]
    end

    def questions(responses)
      questions = questions_catalog
      responses.map { |response| questions = accumulate_questions(response[:variables], questions) }
      questions
    end

    def accumulate_questions(variables, questions)
      variables.inject(questions) do |result, element|
        key = element[:key]
        questions[key] += element[:number] unless !questions.key?(key)
        questions
      end
    end

    def questions_catalog
      SurveyQuestionRepository.all.to_a.inject({}) do |questions, item|
        questions[item[:question]] = 0
        questions
      end
    end

    def calculate_questions_average(questions, responses_length)
      questions.transform_values { |v| v / responses_length }
    end

    def questions_detail(questions)
      questions_detail = questions.map do |key, value|
        question = SurveyQuestion.find_by(question: key)
        { "title": key,
          "category": question.morale_attribute.name,
          "final_score": value }
      end
      { questions: questions_detail }
    end
end
