# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Contacts", type: :request do
  context "Accounts contacts" do
    let(:account) { create(:account) }
    let(:Authorization) { @token }

    path "/api/v1/accounts/{account_id}/contacts" do
      get "Get all contact from an acccount" do
        tags "Accounts"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :account_id, in: :path, type: :integer, description: "id of the account"

        response "404", "contacts not found" do
          let(:account_id) { Contact.first }

          run_test!
        end
      end
    end
  end
end
