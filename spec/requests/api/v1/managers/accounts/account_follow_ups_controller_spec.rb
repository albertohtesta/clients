# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "AccountFollowUp", type: :request do
  include WebmockHelper
  include_context "login_user"

  context "Managers_accounts_follow_up" do
    let(:account) { create(:account) }

    path "/api/v1/managers/{manager_id}/accounts/{account_id}/account_follow_ups" do
      get "Get all accounts follow ups for a manager and an  account" do
        tags "Managers"
        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"
        parameter name: :manager_id, in: :path, type: :integer, description: "id of the manager"
        parameter name: :account_id, in: :path, type: :integer, description: "id of the account"

        response "200", "accounts follow ups found" do
          let(:manager_id) { Account.first.manager_id }
          let(:account_id) { Account.first.id }

          run_test!
        end
      end

      post "Create a follow up for an account as a manager" do
        tags "Managers"
        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"
        parameter name: :manager_id, in: :path, type: :integer, description: "id of the manager"
        parameter name: :account_id, in: :path, type: :integer, description: "id of the account"
        parameter name: :account_follow_ups, in: :body, description: "follow up fields"

        response "201", "create accounts follow ups found" do
          let(:manager_id) { Account.first.manager_id }
          let(:account_id) { Account.first.id }
          let(:account_follow_ups) { { account_follow_ups: { follow_date: Date.today, account_id: } } }

          run_test!
        end
      end
    end
  end
end
