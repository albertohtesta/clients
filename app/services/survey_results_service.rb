# frozen_string_literal: true

class SurveyResultsService < ApplicationService
  attr_accessor :surveys, :result

  def initialize(surveys)
    @surveys = surveys
  end

  def self.survey_results(period, year, team_id, processing_type)
    results = process_all_year(period, year, team_id, processing_type)
    if results.any?
      SurveyResultsService.grand_average(results, period)
    else
      results
    end
  end

  def self.process_all_year(period, year, team_id, processing_type)
    year = year.to_i
    (1..12).inject({}) do |memo, month|
      initial_date = "01/#{month}/#{year}".to_date
      results_by_month = SurveyResultsService.process_month_results(
                         initial_date, initial_date.end_of_month, team_id, processing_type)
      memo[initial_date.strftime("%B")] = results_by_month if results_by_month.any?
      memo
    end
  end

  def self.process_month_results(initial_date, end_date, team_id, processing_type)
    surveys = SurveyRepository.surveys_by_team_dates_status(team_id:,
      initial_date:, end_date:, status: :closed)
    if surveys.any?
      survey_result_service = SurveyResultsService.new(surveys)
      array_of_surveys = survey_result_service.convert_to_array
      results_by_month = survey_result_service.calculate_average(array_of_surveys, processing_type)
      results_by_month
    else
      surveys
    end
  end

  def convert_to_array
    @surveys.map do |survey|   # receive AR relation and return surveys in: surveys[survey[questions{}]]
      survey.questions.inject([]) do |survey_data, question|
        survey_data << questions_in_hash(question)
        survey_data
      end
    end
  end

  def questions_in_hash(question)
    questions = {}
    questions[:title] = question["title"]
    questions[:category] = question["category"]
    questions[:final_score] = question["final_score"]
    questions
  end

  def calculate_average(surveys, processing_type)   # receive surveys arrays and return
    result = accumulate_scores_in_result(surveys)   # one array of results by month [{question}, ..., month_average]
    result = calculate_questions_average_in_result(result)
    result = add_month_average_to_result(result)
    result = calculate_result_by_category(result) unless processing_type == "Q"
    result
  end

  def add_month_average_to_result(result)
    sum_of_scores = result.inject(0) { |sum, element| sum + element[:final_score] }
    result[result.length] = sum_of_scores / result.length unless result.length == 0 # month average, last element
    result
  end

  def calculate_questions_average_in_result(result)
    result.map do |question|
      question[:final_score] = question[:final_score] / surveys.size
      question
    end
  end

  def accumulate_scores_in_result(surveys)
    result = surveys[0]
    surveys.each_with_index do |survey, index|
      if index > 0                                  # the first survey is the result
        survey.each_with_index do |questions, x|
          result[x][:final_score] = result[x][:final_score] + questions[:final_score]
        end
      end
    end
    result
  end

  def calculate_result_by_category(result)
    hash_of_categories = hash_of_categories(result)
    results_by_category = results_by_category(hash_of_categories)    # here return [{},{}]
    results_by_category[results_by_category.length] = result.last    # last element is the month average
    results_by_category
  end

  def hash_of_categories(result)
    result.inject({}) do | hash_result, value |
      if value.is_a? Hash
        category = value[:category]
        if hash_result.key?(category)
          hash_result[category]["score"] += value[:final_score]
          hash_result[category]["counter"] += 1
        else
          hash_result[category] = {
            "score" => value[:final_score],
            "counter" => 1
          }
        end
      end
      hash_result
    end
  end

  def results_by_category(hash_of_categories)
    hash_of_categories.inject([]) do |result_array, (key, value)|
      category = {}
      category[:category] = key
      category[:final_score] = value["score"] / value["counter"]
      result_array << category
    end
  end

  def self.grand_average(results_by_month, period)
    # month average is last element
    sum_of_year = results_by_month.inject(0) { |memo, (key, value)| memo + value[value.length - 1] }
    # quarter_averages = []
    quarter_averages = calculate_quarters(results_by_month)

    results_by_month[:year_average] = sum_of_year / results_by_month.length if period.to_i == 2
    if period.to_i == 1
      quarter_averages.each_with_index do |value, index|
        if value > 0
          text = "Q#{ index + 1}_average"
          results_by_month[text] = value
        end
      end
    end
    results_by_month                  # year and quarterly averages are the last hash elements
  end

  def self.calculate_quarters(surveys_by_month)
    month_averages = {}
    quarter_averages = []
    months = ["January", "February", "March", "April", "May", "June", "July", "August",
              "September", "October", "November", "December" ]
    months.each do |value|
      if surveys_by_month.key?(value)
        month_array = surveys_by_month[value]
        month_averages[value] = month_array[month_array.length - 1]
      else
        month_averages[value] = 0
      end
    end

    quarter_months_with_values = []
    acum_by_quarter = 0
    counter = 0
    month_averages.each do |key, value|
      if value > 0
        acum_by_quarter = acum_by_quarter + 1
      end
      counter = counter + 1
      # check quarter-also could be if counter % 3 == 0 # , but but to make it readable
      if key == "March" || key == "June" || key == "September" || key == "December"
        quarter_months_with_values[(counter / 3) - 1] = acum_by_quarter
        acum_by_quarter = 0
      end
    end
    if quarter_months_with_values[0] > 0
      quarter_averages[0] = (month_averages["January"] + month_averages["February"] + month_averages["March"]) / quarter_months_with_values[0]
    else
      quarter_averages[0] = 0
    end
    if quarter_months_with_values[1] > 0
      quarter_averages[1] = (month_averages["April"] + month_averages["May"] + month_averages["June"]) / quarter_months_with_values[1]
    else
      quarter_averages[1] = 0
    end
    if quarter_months_with_values[2] > 0
      quarter_averages[2] = (month_averages["July"] + month_averages["August"] + month_averages["September"]) / quarter_months_with_values[2]
    else
      quarter_averages[2] = 0
    end
    if quarter_months_with_values[3] > 0
      quarter_averages[3] = (month_averages["October"] + month_averages["November"] + month_averages["December"]) / quarter_months_with_values[3]
    else
      quarter_averages[3] = 0
    end
    quarter_averages
  end
end
