# frozen_string_literal: true

require "test_helper"

module Api
  module V1
    module Salesforce
      class AccountImportsControllerTest < ActionDispatch::IntegrationTest
        def correct_request(params = nil)
          post api_v1_salesforce_account_imports_url, params: params || { accounts: @accounts }
        end

        setup do
          @accounts = File.read Rails.root.join("test", "files", "test_salesforce.json")
          create(:account_status, { status: "New", status_code: "new_project" })
        end

        test "should get created status" do
          correct_request
          assert_response :created
        end

        test "should return saved accounts" do
          correct_request
          response_body = JSON.parse(response.body, symbolize_names: true)
          assert response_body[:accounts][0][:salesforce_id].present?
        end

        test "should get unprocessable_entity code" do
          correct_request({ account: [] })
          assert_response :unprocessable_entity
        end
      end
    end
  end
end
