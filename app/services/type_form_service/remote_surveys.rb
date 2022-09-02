# frozen_string_literal: true

module TypeFormService
  class RemoteSurveys
    def self.all
      HttpClient.new.get("forms")
    end

    def self.find(form_id)
      HttpClient.new.get("forms/#{form_id}")
    end

    def self.update(form_id, options = {})
      HttpClient.new.patch("forms/#{form_id}", options)
    end

    def self.create
      type_form_survey_template = File.join(Rails.root, "app", "services/type_form_service", "typeform_survey_template.txt")
      data = HttpClient.new.post("forms", JSON.parse(File.read(type_form_survey_template)))
      data = safe_json(data) unless data.blank?
      return { typeform_survey_id: data[:id], typeform_survey_url: data[:_links][:display] } unless data.blank?

      { error: "survey not created" }
    end

    def self.survey_url_by_form_id(form_id)
      data = find(form_id)
      return { survey_url: safe_json(data)[:_links][:display] } unless data.blank?

      { error: "not found" }
    end

    protected
      def self.safe_json(content)
        JSON.parse(content, symbolize_names: true)
      rescue JSON::ParserError
        {}
      end
  end
end
