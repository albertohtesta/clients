# frozen_string_literal: true

require "test_helper"

class WebhooksServiceTest < ActiveSupport::TestCase
  BASE_URL = "https://api.typeform.com/"
  ACCESS_TOKEN = ENV["TYPE_FORM_ACCESS_TOKEN"]
  REQUEST_OPTIONS = { enabled: true, url: "https://test.com" }

  test "should fetch all webhooks of a given survey" do
    body = {
            items: [
              {
                created_at: "2016-11-21T12:23:28Z",
                enabled: true,
                form_id: "abc123",
                id: "yRtagDm8AT",
                tag: "phoenix",
                updated_at: "2016-11-21T12:23:28Z",
                url: "https://test.com",
                verify_ssl: true
              }
            ]
          }

    stub_request(:get, "https://api.typeform.com/forms/F5MUTm3J/webhooks").
    with(
      headers: {
      "Accept" => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Authorization" => "Bearer #{ACCESS_TOKEN}",
      "Host" => "api.typeform.com",
      "User-Agent" => "Ruby"
      }).
    to_return(status: 200, body: body.to_json, headers: {})

    assert_equal body, TypeFormService::Webhooks.new.all("F5MUTm3J")
  end

  test "should fetch a given webhook of a given survey" do
    body = {
            created_at: "2016-11-21T12:23:28Z",
            enabled: true,
            form_id: "abc123",
            id: "yRtagDm8AT",
            tag: "phoenix",
            updated_at: "2016-11-21T12:23:28Z",
            url: "https://test.com",
            verify_ssl: true
          }

    stub_request(:get, "https://api.typeform.com/forms/F5MUTm3J/webhooks/asdf").
    with(
      headers: {
      "Accept" => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Authorization" => "Bearer #{ACCESS_TOKEN}",
      "Host" => "api.typeform.com",
      "User-Agent" => "Ruby"
      }).
    to_return(status: 200, body: body.to_json, headers: {})

    assert_equal body, TypeFormService::Webhooks.new.find("F5MUTm3J", "asdf")
  end

  test "should create or update a webhook in a given survey" do
    body = {
            created_at: "2016-11-21T12:23:28Z",
            enabled: true,
            form_id: "abc123",
            id: "yRtagDm8AT",
            tag: "phoenix",
            updated_at: "2016-11-21T12:23:28Z",
            url: "https://test.com",
            verify_ssl: true
          }

    stub_request(:put, "https://api.typeform.com/forms/F5MUTm3J/webhooks/asdf?enabled=true&url=https://test.com").
    with(
      headers: {
      "Accept" => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Authorization" => "Bearer #{ACCESS_TOKEN}",
      "Host" => "api.typeform.com",
      "User-Agent" => "Ruby"
      }).
    to_return(status: 200, body: body.to_json, headers: {})

    assert_equal body, TypeFormService::Webhooks.new.update!("F5MUTm3J", "asdf", REQUEST_OPTIONS)
  end
end
