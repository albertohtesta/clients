# frozen_string_literal: true

require "test_helper"

class AccountImportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    file = File.read Root.join("test", "files", "test_salesforce.json")
    @accounts = JSON.parse(file)
  end
end
