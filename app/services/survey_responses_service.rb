# frozen_string_literal: true

class SurveyResponsesService < ApplicationService
  def self.get_responses(survey_id)
    survey = get_survey(survey_id)
    surveys = get_remote_responses(survey.remote_survey_id)
    questions = {}
    questions = get_questions(questions, surveys)
    questions = calculate_questions_average(questions, surveys.length)
    survey.questions_detail = get_questions_detail(questions)
    survey.save
  end


  def self.close_survey(survey_id)
    survey = get_survey(survey_id)
    return unless survey.present? && survey.status != 2
    get_responses(survey_id)
    survey.reload.status = 2
    TypeFormService::RemoteSurveys.update(survey.remote_survey_id, { "op": "replace", "path": "/settings/is_public", "value": false })
    survey.save
  end

  def self.check_if_survey_should_be_closed(survey_id)
    survey = get_survey(survey_id)
    return unless survey.present? && survey.status != 2 && survey.current_answers >= survey.requested_answers
    close_survey(survey_id) unless survey.remote_survey_id.nil?
  end

  private
    def self.get_survey(survey_id)
      survey ||= Survey.find(survey_id)
      survey
    end

    def self.get_remote_responses(remote_survey_id)
      survey_responses = TypeFormService::Responses.new
      data = survey_responses.all(remote_survey_id)
      data[:items]
    end

    def self.get_questions(questions, surveys)
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

    def self.calculate_questions_average(questions, surveys_length)
      questions.each do |key, value|
        questions[key] = value / surveys_length
      end
      questions
    end

    def self.get_questions_detail(questions)
      questions_detail = questions.map do |key, value|
        question = SurveyQuestion.find_by(question: key)
        { "title": key,
         "category": question.morale_attribute.name,
         "final_score": value }
      end
      { questions: questions_detail }
    end
end
