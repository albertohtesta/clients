# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Accounts", type: :request do
  let(:Authorization) { @token }

  before do
    contact = build(:contact, :user)
    contact.save
    login_as(contact)
  end

  context "Accounts contacts collaborators" do
    let(:contact_collaborator) { create(:account_contact_collaborator) }

    path "/api/v1/accounts/{account_id}/contacts_collaborators" do
      get "Get all collaborators contact from an acccount" do
        tags "Accounts"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :account_id, in: :path, type: :integer, description: "id of the account"

        response "404", "contacts collaborators not found" do
          let(:account_id) { 0 }

          run_test!
        end

        response "200", "contacts collaborators found" do
          let(:account_id) { contact_collaborator.account_id }

          run_test!
        end
      end
    end
  end
end
