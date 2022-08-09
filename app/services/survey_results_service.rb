# frozen_string_literal: true

class SurveyResultsService < ApplicationService
  attr_accessor :surveys, :result

  def initialize(surveys)
    @surveys = surveys
  end

  def self.get_surveys(initial_month, end_month, year, team_id, type)
    initial_month = initial_month.to_i
    end_month = end_month.to_i
    year = year.to_i
    surveys_by_month = {}
    for m in initial_month..end_month do
      initial_date = Date.parse("01/#{m}/#{year}")
      end_date = initial_date.end_of_month
      results_by_month = SurveyResultsService.get_surveys_of_the_month(initial_date, end_date, team_id, type)
      surveys_by_month[initial_date.strftime("%B")] = results_by_month if !results_by_month.empty?
    end
    if !surveys_by_month.empty?
      SurveyResultsService.grand_average(surveys_by_month, type)
    else
      surveys_by_month
    end
  end

  def self.get_surveys_of_the_month(initial_date, end_date, team_id, type)
    surveys = SurveyRepository.surveys_by_team_dates_status(team_id,
              initial_date, end_date, 1)
    if !surveys.empty?
      survey_result_service = SurveyResultsService.new(surveys)
      surveys = survey_result_service.convert_to_array(type == "detail")
      surveys = survey_result_service.calculate_average(surveys) if type == "global"
      surveys
    else
      surveys
    end
  end

  def convert_to_array(include_id)
    all_surveys = []  # recibe AR relation y pone surveys en arrays estructura [surveys][survey][questions]
    @surveys.each do |survey|
      survey_data = []
      survey.questions.each do |question|
        questions = []
        questions[0] = question["title"]
        questions[1] = question["category"]
        questions[2] = question["final_score"]
        questions[3] = survey.id if include_id
        survey_data << questions
      end
      all_surveys << survey_data
    end
    all_surveys
  end

  def calculate_average(surveys)   # recibe arrays de surveys y regresa array de results
    result = surveys[0]
    surveys.each_with_index do |survey, x|
      if x > 0  # procesa a partir del 2o. survey (el 1ro esta en result)
        survey.each_with_index do |questions, x|
          questions.each_with_index do |question, i|
            if i == 2      # incrementa el score en result
              result[x][2] = result[x][2] + question
            end
          end
        end
      end
    end
    num_surveys = surveys.length
    # calcula el promedio en result del mes y por question
    total_average = 0
    result.each do |question|
      question[2] = question[2] / num_surveys # promedio por question
      total_average += question[2]
    end
    result[result.length] = total_average / result.length # promedio del mes
    result
  end

  def self.grand_average(surveys_by_month, type)
    if type == "global"
      sum_of_averages = 0
      surveys_by_month.each do |key, survey|
        sum_of_averages += survey[survey.length - 1]
      end
      surveys_by_month[:gran_average] = sum_of_averages / surveys_by_month.length
      surveys_by_month                  # el promedio del mes es el ultimo elemento del hash
    else
      surveys_by_month
    end
  end
end
