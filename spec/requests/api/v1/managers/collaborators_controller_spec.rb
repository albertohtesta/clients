# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Managers#CollaboratorsController", type: :request do
  include WebmockHelper

  before do
    collaborator = create(:collaborator)
    account = create(:account, manager: collaborator)
    contact = create(:contact, :user, account:)
    project = create(:project, account:)
    team = create(:team, project:)
    create(:team, id: 55)
    create(:collaborators_team, collaborator:, team:)
    login_as(contact)
  end

  context "Managers_accounts" do
    let(:Authorization) { @token }
    path "/api/v1/managers/{manager_id}/accounts/{account_id}/collaborators/{id}" do
      delete "A collaborator from account" do
        tags "Managers"
        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"
        parameter name: :account_id, in: :path, type: :integer, description: "accound_id"
        parameter name: :manager_id, in: :path, type: :integer, description: "accound_id"
        parameter name: :id, in: :path, type: :integer, description: "collaborator_id"


        response "200", "collaborator deleted" do
          let(:account_id) { Account.first.id }
          let(:manager_id) { Account.first.manager_id }
          let(:id) { Collaborator.first.id }

          run_test!
        end
      end
    end
  end
end
