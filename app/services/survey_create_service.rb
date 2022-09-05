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
end
