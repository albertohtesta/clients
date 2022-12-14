# frozen_string_literal: true

class SurveyCreateService < ApplicationService
  class << self
    def get_survey_remote_data(description, survey_url)
      return unless survey_url.blank?

      data = TypeFormService::RemoteSurveys.create
      return unless data.key?(:typeform_survey_url)

      send_survey_description(description, data[:typeform_survey_id])
      { survey_url: data[:typeform_survey_url], remote_survey_id: data[:typeform_survey_id] }
    end

    def send_survey_description(description, survey_id)
      options = { "op": "replace", "path": "/title", "value": description }
      TypeFormService::RemoteSurveys.update(survey_id, options)
    end

    def calculate_started_at(period, period_value, year)
      case period
      when "month"
        "01/#{period_value}/#{year}".to_date
      when "quarter"
        date_for_quarter(period_value, year)
      else
        "01/01/#{year}".to_date
      end
    end

    def date_for_quarter(value, year)
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

    def create_job(survey)
      survey_closing_date = survey.deadline.to_datetime + 1
      SurveyJob.set(wait_until: survey_closing_date).perform_later(survey)
    end
  end
end
