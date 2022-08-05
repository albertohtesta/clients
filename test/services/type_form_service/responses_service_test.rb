# frozen_string_literal: true

require "test_helper"

class ResponsesServiceTest < ActiveSupport::TestCase
  BASE_URL = "https://api.typeform.com/"
  ACCESS_TOKEN = ENV["TYPE_FORM_ACCESS_TOKEN"]

  test "should fetch all responses of a given survey" do
    body = {
            total_items: 1,
            page_count: 1,
            items: [
              {
                landing_id: "asdf1234",
                answers: [
                  {
                    field: {
                      id: "lkjhqw1",
                      type: "rating"
                    },
                    type: "number",
                    number: 2
                  }
                ]
              }
            ]
          }

    stub_request(:get, "https://api.typeform.com/forms/F5MUTm3J/responses").
    with(
      headers: {
      "Accept" => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Authorization" => "Bearer #{ACCESS_TOKEN}",
      "Host" => "api.typeform.com",
      "User-Agent" => "Ruby"
      }).
    to_return(status: 200, body: body.to_json, headers: {})

    assert_equal body, TypeFormService::Responses.new.all("F5MUTm3J")
  end

  test "should fetch insights on a given survey" do
    body = {
            fields: [
              {
                dropoffs: 1,
                id: "aBcDe",
                label: "4",
                ref: "060e5675-aaf4-4b53-8be8-de956aae4c69",
                title: "What is your name?",
                type: "short_text",
                views: 15
              }
            ],
            form: {
              platforms: [
                {
                  average_time: 56000,
                  completion_rate: 45.5,
                  platform: "desktop",
                  responses_count: 100,
                  total_visits: 15,
                  unique_visits: 2
                }
              ],
              summary: {
                average_time: 56000,
                completion_rate: 45.5,
                responses_count: 100,
                total_visits: 15,
                unique_visits: 2
              }
            }
          }

    stub_request(:get, "https://api.typeform.com/insights/F5MUTm3J/summary").
    with(
      headers: {
      "Accept" => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Authorization" => "Bearer #{ACCESS_TOKEN}",
      "Host" => "api.typeform.com",
      "User-Agent" => "Ruby"
      }).
    to_return(status: 200, body: body.to_json, headers: {})

    assert_equal body, TypeFormService::Responses.new.insights("F5MUTm3J")
  end
end
