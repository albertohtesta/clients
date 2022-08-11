# frozen_string_literal: true

require "swagger_helper"

describe "Managers", type: :request do
  before(:each) do
    create(:account)
  end

  context "Managers_accounts" do
    let(:Authorization) { @token }

    path "/api/v1/managers/{manager_id}/accounts" do
      get "Get all accounts of a mannager and with priorities" do
        tags "Managers"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :manager_id, in: :path, type: :integer, description: "id of the manager"


        response "200", "accounts found" do
          let(:manager_id) { Account.first.manager_id }

          run_test!
        end
      end
    end
  end
end
