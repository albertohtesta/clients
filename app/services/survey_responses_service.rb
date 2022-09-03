# frozen_string_literal: true

class SurveyResponsesService < ApplicationService
  attr_accessor :surveys

  def initialize(surveys)
    @surveys = surveys
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
