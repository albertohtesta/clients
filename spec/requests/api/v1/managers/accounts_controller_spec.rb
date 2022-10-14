# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Managers", type: :request do
  include WebmockHelper

  before do
    collaborator = create(:collaborator)
    account = create(:account, manager: collaborator)
    contact = create(:contact, :user, account:)
    login_as(contact)
  end
  context "Managers_accounts" do
    let(:Authorization) { @token }
    path "/api/v1/managers/{manager_id}/accounts" do
      get "Get all accounts of a mannager and with priorities" do
        tags "Managers"
        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"
        parameter name: :manager_id, in: :path, type: :integer, description: "id of the manager"


        response "200", "accounts found" do
          let(:manager_id) { Account.first.manager_id }

          run_test!
        end
      end
    end
  end

  context "Managers_accounts by admin user" do
    before do
      collaborator = create(:collaborator, email: "my@email.com", uuid: "8783-1232-3345-2343")
      account = create(:account, manager: collaborator)
      create(:contact, :user, account:, email: collaborator.email, uuid: "8783-1232-3345-2343")
      login_as(collaborator, "admin")
    end

    let(:Authorization) { @token }
    path "/api/v1/managers/{manager_id}/accounts" do
      get "Get all accounts of a mannager and with priorities" do
        tags "Managers"
        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"
        parameter name: :manager_id, in: :path, type: :integer, description: "id of the manager"

        response "200", "when I am an admin" do
          let(:manager_id) { Account.first.manager_id }

          run_test!
        end
      end
    end
  end

  context "When user is admin and select all accounts" do
    before do
      collaborator = create(:collaborator, email: "my@email.com", uuid: "8783-1232-3345-2343")
      account = create(:account, manager: collaborator)
      create(:contact, :user, account:, email: collaborator.email, uuid: "8783-1232-3345-2343")
      login_as(collaborator, "admin")
    end

    let(:Authorization) { @token }
    path "/api/v1/managers/:manager_id/account_as_admin" do
      get "Get all accounts of a mannager and with priorities" do
        tags "Managers"
        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"
        parameter name: :manager_id, in: :path, type: :integer, description: "id of the manager"

        response "200", "when I am an admin" do
          let(:manager_id) { Account.first.manager_id }

          run_test!
        end
      end
    end
  end

  context "When user is not admin and select all accounts" do
    before do
      collaborator = create(:collaborator, email: "my@email.com", uuid: "8783-1232-3345-2343")
      account = create(:account, manager: collaborator)
      create(:contact, :user, account:, email: collaborator.email, uuid: "8783-1232-3345-2343")
      login_as(collaborator)
    end

    let(:Authorization) { @token }
    path "/api/v1/managers/:manager_id/account_as_admin" do
      get "Get all accounts of a mannager and with priorities" do
        tags "Managers"
        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"
        parameter name: :manager_id, in: :path, type: :integer, description: "id of the manager"

        response "404", "when I am an admin" do
          let(:manager_id) { Account.first.manager_id }

          run_test!
        end
      end
    end
  end
end
