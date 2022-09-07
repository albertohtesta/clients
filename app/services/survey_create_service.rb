# frozen_string_literal: true

class SurveyCreateService < ApplicationService
  def self.get_survey_remote_data(description, survey_url)
    return unless survey_url.blank?

    data = TypeFormService::RemoteSurveys.create
    return unless data.key?(:typeform_survey_url)

    send_survey_description(description, data[:typeform_survey_id])
    { survey_url: data[:typeform_survey_url], remote_survey_id: data[:typeform_survey_id] }
  end

  def self.send_survey_description(description, survey_id)
    options = { "op": "replace", "path": "/title", "value": description }
    TypeFormService::RemoteSurveys.update(survey_id, options)
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
