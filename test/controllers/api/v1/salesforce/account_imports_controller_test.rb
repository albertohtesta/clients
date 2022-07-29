# frozen_string_literal: true

require "test_helper"

module Api
  module V1
    module Salesforce
      class AccountImportsControllerTest < ActionDispatch::IntegrationTest
        def correct_request(params = nil)
          params = @account if params.nil?
          post api_v1_salesforce_account_imports_url, headers: { "Authorization" => @token }, params:
        end

        setup do
          stub_cognito_uri
          @account = File.read Rails.root.join("test", "files", "test_salesforce.json")
          create(:account_status, { status: "New", status_code: "new_project" })
        end

        test "should get created status" do
          correct_request
          assert_response :created
        end

        test "should return saved account" do
          correct_request
          response_body = JSON.parse(response.body, symbolize_names: true)
          assert response_body[:account][:salesforce_id].present?
        end

        test "should get unprocessable_entity code" do
          correct_request("{ account: [] }")
          assert_response :unprocessable_entity
        end
      end
    end
  end
end
