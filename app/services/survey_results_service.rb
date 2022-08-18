# frozen_string_literal: true

class SurveyResultsService < ApplicationService
  attr_accessor :surveys, :result

  def initialize(surveys)
    @surveys = surveys
  end

  def self.get_results(period, year, team_id)
    initial_month = 1
    end_month = 12
    year = year.to_i
    results = {}
    (initial_month..end_month).each do |month|
      initial_date = "01/#{month}/#{year}".to_date
      end_date = initial_date.end_of_month
      results_by_month = SurveyResultsService.process_results(initial_date, end_date, team_id)
      results[initial_date.strftime("%B")] = results_by_month if results_by_month.any?
    end
    if results.any?
      SurveyResultsService.grand_average(results, period)
    else
      results
    end
  end

  def self.process_results(initial_date, end_date, team_id)
    surveys = SurveyRepository.surveys_by_team_dates_status(team_id,
              initial_date, end_date, 2)
    if surveys.any?
      survey_result_service = SurveyResultsService.new(surveys)
      surveys = survey_result_service.convert_to_array
      surveys = survey_result_service.calculate_average(surveys)
      surveys
    else
      surveys
    end
  end

  def convert_to_array
    @surveys.map do |survey|   # receive AR relation y pone surveys en: surveys[survey[questions{}]]
      survey_data = []
      survey.questions.each do |question|
        survey_data << questions_in_hash(question)  # here we have: survey[{question}]
      end
      survey_data
    end
  end

  def questions_in_hash(question)
    questions = {}
    questions[:title] = question["title"]
    questions[:category] = question["category"]
    questions[:final_score] = question["final_score"]
    questions
  end

  def calculate_average(surveys)   # receive surveys arrays and return array of results by month
    result = surveys[0]
    surveys.each_with_index do |survey, x|
      if x > 0  # the first survey is the result
        survey.each_with_index do |questions, x|
          questions.each_with_index do |key, value|
            if key == :final_score      # increment score in result
              result[x][:final_score] = result[x][:final_score] + value
            end
          end
        end
      end
    end
    # average in result by month and question
    total_average = 0
    result.each do |question|
      question[:final_score] = question[:final_score] / surveys.size
      total_average += question[:final_score]
    end
    result[result.length] = total_average / result.length # month average, last element
    result  # here returns results by month = [{question}]
  end

  def self.grand_average(surveys_by_month, period)
    sum_of_year = 0
    acum_by_quarter = 0
    counter = 1
    quarter_averages = []

    surveys_by_month.each do |key, survey|
      sum_of_year += survey[survey.length - 1] # month average is last element
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
        text = "Q#{ index + 1}_average"
        surveys_by_month[text] = value
      end
    end
    surveys_by_month                  # year and quarterly averages are the last hash elements
  end
end
