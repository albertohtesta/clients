# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/api/v1/public/collaborators", type: :request do
  let(:Authorization) { @token }

  before do
    contact = build(:contact)
    contact.save
    login_as(contact)
  end

  context "Collaborators" do
    path "/api/v1/public/collaborators/{id}" do
      get "Get a collaborator" do
        tags "Collaborators"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :id, in: :path, type: :integer, description: "id of the collaborator"
        parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"


        response "200", "collaborator found" do
          let!(:collaborator) { create(:collaborator) }
          let(:id) { Collaborator.first.id }

          run_test!
        end

        response "404", "collaborator not found" do
          let(:id) { 0 }

          run_test!
        end
      end
    end

    path "/api/v1/public/accounts/{account_id}/collaborators" do
      get "Get talent pool directory" do
        tags "Collaborators"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"
        parameter name: :account_id, in: :path, type: :integer, description: "id of the account"

        response "200", "talent pool directory found" do
          let(:account_id) { Account.first.id }
          collaborator_ids = [1, 2, 3, 4, 5, 6, 7, 200, 201, 202, 203]
          collaborator_ids.map do |id|
            let!(:"collaborator#{id}") { create(:collaborator, id:) }
            let!(:"accounts_collaborator#{id}") { create(:accounts_collaborator, collaborator_id: id, account_id: Account.first.id) }
          end

          run_test!
        end

        response "404", "talent pool directory not found" do
          let(:account_id) { Account.first.id }

          run_test!
        end
      end
    end

    path "/api/v1/public/accounts/{account_id}/collaborators" do
      get "Get talent pool directory" do
        tags "Collaborators"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :account_id, in: :path, type: :integer, description: "id of the account"
        parameter name: :category, in: :query, type: :string, description: "filter by category", required: false, allowReserved: true

        response "200", "talent pool directory filtered found" do
          let(:account_id) { Account.first.id }
          collaborator_ids = [1, 2, 3, 4, 5, 6, 7, 200, 202, 203]
          collaborator_ids.map do |id|
            let!(:"collaborator#{id}") { create(:collaborator, id:) }
            let!(:"accounts_collaborator#{id}") { create(:accounts_collaborator, collaborator_id: id, account_id: Account.first.id) }
          end

          let!(:category) { "DEVELOPER" }

          run_test!
        end
      end
    end
  end
end
