# frozen_string_literal: true

module TypeFormService
  # Services for remote surveys
  class RemoteSurveys
    TYPE_FORM_SURVEY_TEMPLATE = '{
        "type": "score",
        "title": "survey from my APP",
        "workspace": {
            "href": "https://api.typeform.com/workspaces/Gmuu7V"
        },
        "theme": {
            "href": "https://api.typeform.com/themes/qHWOQ7"
        },
        "fields": [
            {
                "title": "Lenguaje favorito",
                "ref": "01GA4WRMQYVJTBXMRE0N8F78GA",
                "properties": {
                    "randomize": false,
                    "allow_multiple_selection": false,
                    "allow_other_choice": false,
                    "vertical_alignment": true,
                    "choices": [
                        {
                            "ref": "802db58b-9058-4037-bb63-f60ff6561435",
                            "label": "Ruby"
                        },
                        {
                            "ref": "cb6a6398-5113-4b3c-883b-c97a68f1f21a",
                            "label": "JS"
                        },
                        {
                            "ref": "1e383af9-f6b5-44fb-aa85-a8b9c1d9647c",
                            "label": "Phyton"
                        }
                    ]
                },
                "validations": {
                    "required": false
                },
                "type": "multiple_choice",
                "attachment": {
                    "type": "image",
                    "href": "https://images.typeform.com/images/WMALzu59xbXQ"
                },
                "layout": {
                    "type": "split",
                    "attachment": {
                        "type": "image",
                        "href": "https://images.typeform.com/images/WMALzu59xbXQ"
                    }
                }
            },
            {
                "title": "Framework favorito",
                "ref": "01GA4WRMRAHZ5G8QDJKF4S0J21",
                "properties": {
                    "randomize": false,
                    "allow_multiple_selection": false,
                    "allow_other_choice": false,
                    "vertical_alignment": true,
                    "choices": [
                        {
                            "ref": "01GA4WRMRAKPRHV39F35AD8ZEF",
                            "label": "RoR"
                        },
                        {
                            "ref": "01GA4WRMRA6A4EQHM0N07C6VFZ",
                            "label": "React"
                        },
                        {
                            "ref": "da9cc74b-974d-4a1d-a011-4602babbc168",
                            "label": "Django"
                        }
                    ]
                },
                "validations": {
                    "required": false
                },
                "type": "multiple_choice"
            },
            {
                "title": "Equipo favorito",
                "ref": "2ffd257f-ddf0-40a6-9351-705b42530f28",
                "properties": {
                    "randomize": false,
                    "allow_multiple_selection": false,
                    "allow_other_choice": false,
                    "vertical_alignment": true,
                    "choices": [
                        {
                            "ref": "a5bfe8f6-e64e-4381-8859-2ecd4159c1ad",
                            "label": "Mac"
                        },
                        {
                            "ref": "92066b2b-2874-4b07-84b0-731d602d1208",
                            "label": "Windows"
                        },
                        {
                            "ref": "52329ea1-1c3d-470d-9108-dd59f48a6098",
                            "label": "Linux"
                        }
                    ]
                },
                "validations": {
                    "required": false
                },
                "type": "multiple_choice"
            },
            {
                "title": "Ciudad favorita",
                "ref": "7f711eb0-f37a-4728-a67a-e7d1b8454e4f",
                "properties": {
                    "randomize": false,
                    "allow_multiple_selection": false,
                    "allow_other_choice": false,
                    "vertical_alignment": true,
                    "choices": [
                        {
                            "ref": "07b2ce1b-212f-4165-b03b-e465c655a27d",
                            "label": "Colima"
                        },
                        {
                            "ref": "40de1173-087d-4de3-977e-3bd0816596b8",
                            "label": "Cancun"
                        },
                        {
                            "ref": "6fb1a9ac-b35a-4f5a-b472-71a5bf1755f6",
                            "label": "CDMX"
                        }
                    ]
                },
                "validations": {
                    "required": false
                },
                "type": "multiple_choice"
            }
        ]
     }'

    def all
      HttpClient.new.get("forms")
    end
    def find(form_id)
      HttpClient.new.get("forms/#{form_id}")
    end

    def update(form_id, options = {})
      HttpClient.new.patch("forms/#{form_id}", options)
    end
    # create a remote survey
    def create
      data = HttpClient.new.post("forms", JSON.parse(TYPE_FORM_SURVEY_TEMPLATE))
      if data.present?
        result = JSON.parse(data, symbolize_names: true)
        result = { typeform_survey_id: result[:id], typeform_survey_url: result[:_links][:display] }
      else
        result = { error: "survey not created" }
      end
      result
    end
    # Returns a survey's url by id
    def survey_url(form_id)
      data = find(form_id)
      if data.present?
        result = JSON.parse(data, symbolize_names: true)
        result = { survey_url: result[:_links][:display] }
      else
        result = { error: "not found" }
      end
      result
    end
  end
end
