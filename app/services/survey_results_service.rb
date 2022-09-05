# frozen_string_literal: true

class SurveyResultsService < ApplicationService
  attr_accessor :surveys, :result

  def initialize(surveys)
    @surveys = surveys
  end

  def self.get_results(period, year, team_id, processing_type)
    initial_month = 1
    end_month = 12
    year = year.to_i
    results = {}
    (initial_month..end_month).each do |month|
      initial_date = "01/#{month}/#{year}".to_date
      end_date = initial_date.end_of_month
      results_by_month = SurveyResultsService.process_results(initial_date, end_date, team_id, processing_type)
      results[initial_date.strftime("%B")] = results_by_month if results_by_month.any?
    end
    if results.any?
      SurveyResultsService.grand_average(results, period)
    else
      results
    end
  end

  def self.process_results(initial_date, end_date, team_id, processing_type)
    surveys = SurveyRepository.surveys_by_team_dates_status(team_id,
              initial_date, end_date, 2)
    if surveys.any?
      survey_result_service = SurveyResultsService.new(surveys)
      surveys = survey_result_service.convert_to_array
      surveys = survey_result_service.calculate_average(surveys, processing_type)
      surveys
    else
      surveys
    end
  end

  def convert_to_array
    @surveys.map do |survey|   # receive AR relation y put surveys in: surveys[survey[questions{}]]
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

  def calculate_average(surveys, processing_type)   # receive surveys arrays and return array of results by month
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
    result[result.length] = total_average / result.length unless result.length == 0 # month average, last element
    if processing_type == "Q"
      result
    else
      result = calculate_result_by_category(result)
    end
    # here returns results by month = [{question}]
  end

  def calculate_result_by_category(result)
    result_by_category = []
    hash_of_categories = {}
    average = 0
    result.each_with_index do |value, index|      # put the categories in hash_of_categories
      if (index + 1) < result.length
        category = value[:category]
        if hash_of_categories.key?(category)
          hash_of_categories[category]["score"] += value[:final_score]
          hash_of_categories[category]["counter"] += 1
        else
          hash_of_categories[category] = {
            "score" => value[:final_score],
            "counter" => 1
          }
        end
      else
        average = result[index]
      end
    end

    hash_of_categories.each do |key, value|    # now calculate the average by category with the same structure
      result = {}
      result["category"] = key
      result["final_score"] = value["score"] / value["counter"]
      result_by_category << result
    end
    result_by_category[result_by_category.length] = average
    result_by_category
  end

  def self.grand_average(surveys_by_month, period)
    sum_of_year = 0
    surveys_by_month.each do |key, survey|
      sum_of_year += survey[survey.length - 1] # month average is last element
    end

    # quarter_averages = []
    quarter_averages = calculate_quarters(surveys_by_month)

    surveys_by_month[:year_average] = sum_of_year / surveys_by_month.length if period.to_i == 2
    if period.to_i == 1
      quarter_averages.each_with_index do |value, index|
        if value > 0
          text = "Q#{ index + 1}_average"
          surveys_by_month[text] = value
        end
      end
    end
    surveys_by_month                  # year and quarterly averages are the last hash elements
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
