# frozen_string_literal: true

class SurveyResultsService < ApplicationService
  class << self
    def survey_results(period, year, team_id, processing_type)
      results = process_all_year(period, year, team_id, processing_type)
      if results.any?
        grand_average(results, period)
      else
        results
      end
    end

    private
      def process_all_year(period, year, team_id, processing_type)
        year = year.to_i
        (1..12).inject({}) do |memo, month|
          initial_date = "01/#{month}/#{year}".to_date
          results_by_month = process_month_results(
                            initial_date, initial_date.end_of_month, team_id, processing_type)
          memo[initial_date.strftime("%B")] = results_by_month if results_by_month.any?
          memo
        end
      end

      def process_month_results(initial_date, end_date, team_id, processing_type)
        surveys = SurveyRepository.surveys_by_team_dates_status(team_id:,
          initial_date:, end_date:, status: :closed)
        if surveys.any?
          array_of_surveys = convert_to_array(surveys).compact
          return array_of_surveys unless !array_of_surveys.empty?
          results_by_month = calculate_average(array_of_surveys, processing_type)
          results_by_month
        else
          surveys
        end
      end

      def convert_to_array(surveys)
        surveys.map do |survey|   # receive AR relation and return surveys in: surveys[survey[questions{}]]
          if survey.questions
            survey.questions.inject([]) do |survey_data, question|
              survey_data << questions_in_hash(question)
              survey_data
            end
          end
        end
      end

      def questions_in_hash(question)
        questions = {}
        questions.tap do |questions|
          questions[:title] = question["title"]
          questions[:category] = question["category"]
          questions[:final_score] = question["final_score"]
        end
      end

      def calculate_average(surveys, processing_type)   # receive surveys arrays and return
        result = accumulate_scores_in_result(surveys)   # one array of results by month [{question}, ..., month_average]
        result = calculate_questions_average_in_result(result, surveys.size)
        result = add_month_average_to_result(result)
        result = calculate_result_by_category(result) unless processing_type == "Q"
        result
      end

      def add_month_average_to_result(result)
        sum_of_scores = result.inject(0) { |sum, element| sum + element[:final_score] }
        result[result.length] = sum_of_scores / result.length unless result.length == 0 # month average, last element
        result
      end

      def calculate_questions_average_in_result(result, surveys_size)
        result.map do |question|
          question[:final_score] = question[:final_score] / surveys_size
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
              hash_result[category] = { "score" => value[:final_score], "counter" => 1 }
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

      def grand_average(results_by_month, period)
        sum_of_year = results_by_month.inject(0) { |memo, (key, value)| memo + value[value.length - 1] } # month average is last element
        quarter_averages = calculate_quarters(results_by_month) # quarter_averages = []
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

      def calculate_quarters(results_by_month)
        months_with_quarters = { "January" => 0, "February" => 0, "March" => 0, "April" => 1, "May" => 1, "June" => 1,
          "July" => 2, "August" => 2, "September" => 2, "October" => 3, "November" => 3, "December" => 3 }
        number_of_months_with_values_in_quarter = Array.new(4, 0)
        sum_of_scores_in_quarter = months_with_quarters.inject(Array.new(4, 0)) do |memo, (key, value)|
          if results_by_month.key?(key)
            results_by_month[key].last > 0 ? number_of_months_with_values_in_quarter[value] += 1 : number_of_months_with_values_in_quarter[value] += 0
            results_by_month[key].last > 0 ? memo[value] += results_by_month[key].last : memo[value] += 0
          end
          memo
        end
        calculate_quarter_averages(sum_of_scores_in_quarter, number_of_months_with_values_in_quarter)
      end

      def calculate_quarter_averages(sum_of_scores_in_quarter, number_of_months_with_values_in_quarter)
        sum_of_scores_in_quarter.map.with_index do |value, index|
          value > 0 && number_of_months_with_values_in_quarter[index] > 0 ? value / number_of_months_with_values_in_quarter[index] : 0
        end
      end
  end
end
