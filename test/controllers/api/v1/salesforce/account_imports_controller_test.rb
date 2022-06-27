# frozen_string_literal: true

require "test_helper"

module Api
  module V1
    module Salesforce
      class AccountImportsControllerTest < ActionDispatch::IntegrationTest
        test "should get unauthorized code" do
          @accounts = File.read Rails.root.join("test", "files", "test_salesforce.json")
          post api_v1_salesforce_account_imports_url, params: @accounts
          assert_response :unauthorized
        end
      end
    end
  end
end
