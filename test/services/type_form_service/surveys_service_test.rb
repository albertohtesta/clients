# frozen_string_literal: true

require "test_helper"

class SurveysServiceTest < ActiveSupport::TestCase
  BASE_URL = "https://api.typeform.com/"
  ACCESS_TOKEN = ENV["TYPE_FORM_ACCESS_TOKEN"]

  test "should fetch all surveys" do
    body = {
            total_items: 1,
            page_count: 1,
            items: [
              {
                id: "F5MUTm3J",
                type: "quiz",
                title: "My test typeform",
                _links: { display: "www.someuri.com" }
              }
            ]
          }

    stub_request(:get, "https://api.typeform.com/forms").
    with(
      headers: {
      "Accept" => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Authorization" => "Bearer #{ACCESS_TOKEN}",
      "Host" => "api.typeform.com",
      "User-Agent" => "Ruby"
      }).
    to_return(status: 200, body: body.to_json, headers: {})

    assert_equal body, TypeFormService::Surveys.new.all
  end

  test "should fetch a given survey" do
    body = {
            id: "F5MUTm3J",
            type: "quiz",
            title: "My test typeform",
            _links: { display: "www.someuri.com" }
          }

    stub_request(:get, "https://api.typeform.com/forms/F5MUTm3J").
    with(
      headers: {
      "Accept" => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Authorization" => "Bearer #{ACCESS_TOKEN}",
      "Host" => "api.typeform.com",
      "User-Agent" => "Ruby"
      }).
    to_return(status: 200, body: body.to_json, headers: {})

    assert_equal body, TypeFormService::Surveys.new.find("F5MUTm3J")
  end

  test "should fetch the url of a given survey" do
    body = {
            id: "F5MUTm3J",
            type: "quiz",
            title: "My test typeform",
            _links: { display: "www.someuri.com" }
          }

    stub_request(:get, "https://api.typeform.com/forms/F5MUTm3J").
    with(
      headers: {
      "Accept" => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Authorization" => "Bearer #{ACCESS_TOKEN}",
      "Host" => "api.typeform.com",
      "User-Agent" => "Ruby"
      }).
    to_return(status: 200, body: body.to_json, headers: {})

    assert_equal "www.someuri.com", TypeFormService::Surveys.new.url("F5MUTm3J")
  end
end
