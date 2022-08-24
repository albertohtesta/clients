# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Accounts", type: :request do
  context "Accounts contacts collaborators" do
    let(:account) { create(:account) }
    let(:contact) { create(:account_contact_collaborator, account: @account) }
    let(:Authorization) { @token }

    path "/api/v1/accounts/{account_id}/contacts_collaborators" do
      get "Get all collaborators contact from an acccount" do
        tags "Accounts"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :account_id, in: :path, type: :integer, description: "id of the account"

        response "404", "contacts collaborators not found" do
          let(:account_id) {  "123" }

          run_test!
        end
      end
    end
  end
end
