# frozen_string_literal: true

class SurveyResultsService < ApplicationService
  attr_accessor :surveys, :result

  def initialize(surveys)
    @surveys = surveys
  end

  def self.get_surveys(period, year, team_id)
    initial_month = 1
    end_month = 12
    year = year.to_i
    surveys_by_month = {}
    for m in initial_month..end_month do
      initial_date = Date.parse("01/#{m}/#{year}")
      end_date = initial_date.end_of_month
      results_by_month = SurveyResultsService.get_surveys_of_the_month(initial_date, end_date, team_id)
      surveys_by_month[initial_date.strftime("%B")] = results_by_month if !results_by_month.empty?
    end
    if !surveys_by_month.empty?
      SurveyResultsService.grand_average(surveys_by_month, period)
    else
      surveys_by_month
    end
  end

  def self.get_surveys_of_the_month(initial_date, end_date, team_id)
    surveys = SurveyRepository.surveys_by_team_dates_status(team_id,
              initial_date, end_date, 1)
    if !surveys.empty?
      survey_result_service = SurveyResultsService.new(surveys)
      surveys = survey_result_service.convert_to_array
      surveys = survey_result_service.calculate_average(surveys)
      surveys
    else
      surveys
    end
  end

  def convert_to_array
    all_surveys = []  # receive AR relation y return surveys in arrays [surveys][survey][questions]
    @surveys.each do |survey|
      survey_data = []
      survey.questions.each do |question|
        questions = []
        questions[0] = question["title"]
        questions[1] = question["category"]
        questions[2] = question["final_score"]
        survey_data << questions
      end
      all_surveys << survey_data
    end
    all_surveys
  end

  def calculate_average(surveys)   # receive surveys arrayas and return array of results
    result = surveys[0]
    surveys.each_with_index do |survey, x|
      if x > 0  # the first survey is the result
        survey.each_with_index do |questions, x|
          questions.each_with_index do |question, i|
            if i == 2      # increment score in result
              result[x][2] = result[x][2] + question
            end
          end
        end
      end
    end
    num_surveys = surveys.length
    # average in result by month and question
    total_average = 0
    result.each do |question|
      question[2] = question[2] / num_surveys
      total_average += question[2]
    end
    result[result.length] = total_average / result.length # month average
    result
  end

  def self.grand_average(surveys_by_month, period)
    sum_of_year = 0
    acum_by_quarter = 0
    counter = 1
    quarter_averages = []

    surveys_by_month.each do |key, survey|
      sum_of_year += survey[survey.length - 1]
      acum_by_quarter += survey[survey.length - 1]
      if counter % 3 == 0 # check quarter
        quarter_averages[(counter / 3) - 1] = acum_by_quarter / 3
        acum_by_quarter = 0
      end
      counter += 1
    end

    surveys_by_month[:year_average] = sum_of_year / surveys_by_month.length if period.to_i == 2
    if period.to_i == 1
      quarter_averages.each_with_index do |value, index|
        text = "Q#{ index + 1}_average".to_s
        surveys_by_month[text] = value
      end
    end
    surveys_by_month                  # year and quarterly averages are the last hash elements
  end
end
