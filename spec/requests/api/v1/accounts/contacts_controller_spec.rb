# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "AccountContacts", type: :request do
  include_context "login_user"

  context "Accounts contacts" do
    let(:account) { create(:account) }
    let(:contact) { create(:contact) }

    path "/api/v1/accounts/{account_id}/contacts" do
      get "Get all contact from an acccount" do
        tags "Accounts"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :account_id, in: :path, type: :integer, description: "id of the account"

        response "200", "contacts found" do
          let(:account_id) { contact.account_id }

          run_test!
        end

        response "404", "contacts not found" do
          let(:account_id) { 0 }

          run_test!
        end
      end
    end

    path "/api/v1/accounts/{account_id}/contacts/{id}" do
      get "Get information of a contact from an acccount" do
        tags "Accounts"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :account_id, in: :path, type: :integer, description: "id of the account"
        parameter name: :id, in: :path, type: :integer, description: "id of the contact related to the account"

        response "200", "contacts found" do
          let(:account_id) { contact.account_id }
          let(:id) { contact.id }

          run_test!
        end

        response "404", "contacts not found" do
          let(:account_id) { 0 }
          let(:id) { 0 }

          run_test!
        end
      end
    end
  end
end
